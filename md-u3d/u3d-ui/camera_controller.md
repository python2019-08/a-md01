# 1.如何修改下面的脚本，把旋转倾角 限制一个范围
```cs
如何修改下面的脚本，把旋转倾角 限制一个范围


public class CameraMove : MonoBehaviour
{
    public float _MoveSpeed = 50.0f;
    // 设置移动范围
    public float minX = -400f;
    public float maxX = -209f;
    public float minZ = 0f;
    public float maxZ = 118f;
    public float fixedHeight = 88f;  // 固定高度

    public float _RotateSpeed = 2.0f;
    // Start is called before the first frame update
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        CameraMoveFunc();
    }

    void CameraMoveFunc()
    {
        if (Input.GetMouseButton(1))
        {
 
            float h = -Input.GetAxis("Mouse X") ;
            float v = -Input.GetAxis("Mouse Y") ;
            
            Vector3 rightDir = transform.right;
            rightDir.y = 0;
            rightDir.Normalize();

            Vector3  forwardDir = transform.forward;
            forwardDir.y = 0;
            forwardDir.Normalize();
            
            Vector3 movement = (rightDir * h + forwardDir * v)* _MoveSpeed * Time.deltaTime;;
            // transform.position += movement ;
            // transform.Translate(movement,Space.World);

            // 计算新位置
            Vector3 newPosition = transform.position + movement;
            
            // 使用Mathf.Clamp限制X和Z坐标范围
            newPosition.x = Mathf.Clamp(newPosition.x, minX, maxX);
            newPosition.z = Mathf.Clamp(newPosition.z, minZ, maxZ);
            newPosition.y = fixedHeight;  // 保持固定高度
            
            transform.position = newPosition;            

        } 
        else if (Input.GetMouseButton(0))
        {
            float h = -Input.GetAxis("Mouse X") ;
            float v = -Input.GetAxis("Mouse Y") ;

            transform.Rotate(Vector3.up * h * _RotateSpeed, Space.World);
            transform.Rotate(Vector3.right * v * _RotateSpeed, Space.Self);
        }
    }
}
```

## YuanbaoAI deepthink:

我们需要限制相机旋转的倾角，即绕X轴旋转的角度（在本地坐标系中）应该在一个范围内，比如[-30, 30]度。
当前代码中，当按下鼠标左键时，相机会绕世界的Y轴（水平旋转）和绕自身的X轴（垂直旋转，即倾角）旋转。
问题在于，绕自身X轴旋转可能会使相机倾角过大，导致画面颠倒或不自然。
解决方案：
我们需要记录当前绕X轴旋转的角度，并限制在最小和最大角度之间。
注意：Unity中旋转使用欧拉角，我们可以通过限制本地欧拉角的X轴来实现。
步骤：
a. 在类中添加两个变量，用于限制X轴旋转的角度范围，比如minVerticalAngle和maxVerticalAngle。
b. 在旋转时，我们分别处理水平旋转（Y轴）和垂直旋转（X轴）。水平旋转不受限制，垂直旋转需要限制。
c. 注意：我们使用Transform.Rotate来旋转，但这样会累计旋转，我们需要在旋转后检查并限制角度。
但是，直接使用Rotate然后限制欧拉角可能会遇到万向锁问题，但在这个简单案例中，我们只绕两个轴旋转，可以接受。
另一种方法是：先计算旋转后的欧拉角，然后限制X轴欧拉角，再赋值。
修改思路：
我们不再直接使用Transform.Rotate，而是先计算旋转量，然后应用到变换的欧拉角上，并限制X轴的角度。
具体修改：
我们可以将旋转操作改为：
记录当前的欧拉角
根据鼠标输入修改欧拉角
限制X轴欧拉角在[minVerticalAngle, maxVerticalAngle]之间
将欧拉角赋值给transform
注意：Unity中欧拉角的X轴范围是0~360，但我们可以限制在[-30,30]这样的范围，但要注意连续旋转时角度可能会超出这个范围，所以我们需要将角度限制在合理范围内。
由于我们之前是分别绕世界Y轴和自身X轴旋转，现在改为统一用欧拉角控制。
修改后的代码：
我们将使用一个Vector3来存储旋转角度，然后应用限制。
但是，注意：我们水平旋转是绕世界Y轴，而垂直旋转是绕自身X轴。如果我们先水平旋转再垂直旋转，那么垂直旋转的轴会因为水平旋转而改变吗？实际上，我们希望的是：
水平旋转：绕世界Y轴旋转（不会因为相机倾斜而改变）
垂直旋转：绕相机自身的X轴旋转（即左右旋转不会影响垂直旋转的轴）
但是，如果我们用欧拉角来控制，我们可以先调整Y轴（水平），再调整X轴（垂直），并且限制X轴。
另一种方法：使用Quaternion来旋转，但这里我们使用欧拉角比较简单。
步骤：
定义两个变量：minVerticalAngle和maxVerticalAngle，比如-30和30。
在鼠标左键按下时，获取鼠标移动量，然后修改当前相机的欧拉角。
注意：欧拉角的X轴是垂直旋转，Y轴是水平旋转。
但是，我们原来的旋转顺序是：先绕世界Y轴旋转（水平），然后绕自身X轴旋转（垂直）。这个顺序在欧拉角中如何表示？
在Unity中，欧拉角的旋转顺序是ZXY，但我们可以通过设置旋转顺序来控制。不过，我们这里简单处理，先计算水平旋转（Y轴），再计算垂直旋转（X轴），并且垂直旋转是相对于当前相机的。
实际上，我们可以这样：
水平旋转：直接修改欧拉角的Y轴（世界Y轴）
垂直旋转：修改欧拉角的X轴（本地X轴），然后限制X轴。
注意：欧拉角的X轴范围，我们可以直接限制。
代码修改：
我们将不再使用Transform.Rotate，而是直接修改transform.eulerAngles。
但是，注意：欧拉角是0~360，而我们的限制范围可能是负值，所以我们需要将欧拉角转换为-180~180的范围来限制。
我们可以使用Mathf.Clamp来限制角度，但需要将欧拉角转换为连续的角度。
我们可以写一个方法将角度限制在-180~180，然后限制在minVerticalAngle和maxVerticalAngle之间。
但是，Unity的欧拉角在0~360，所以我们需要先转换为-180~180，限制后再转换回0~360。
另一种方法是：使用Mathf.Clamp，但要注意角度的循环。
我们可以使用如下方法：
float ClampAngle(float angle, float min, float max)
{
if (angle < -360) angle += 360;
if (angle > 360) angle -= 360;
return Mathf.Clamp(angle, min, max);
}
但是，Unity的欧拉角通常是在0~360，所以我们先将其转换为-180~180，然后限制，再转换回0~360？其实不需要，我们可以直接限制在0~360，但我们的范围是-30~30，所以我们需要将欧拉角转换为-180~180。
步骤：
获取当前的欧拉角
将欧拉角转换为-180~180的范围
根据鼠标输入修改欧拉角（注意：鼠标移动方向）
限制X轴欧拉角
将欧拉角赋值回去
代码实现：
我们修改鼠标左键的旋转部分。
注意：我们之前是使用Transform.Rotate，现在改为直接操作欧拉角。
具体代码：
我们添加一个限制角度的方法：
private float ClampAngle(float angle, float min, float max)
{
if (angle < -360) angle += 360;
if (angle > 360) angle -= 360;
return Mathf.Clamp(angle, min, max);
}
然后修改旋转部分：
Vector3 euler = transform.eulerAngles;
// 水平旋转：绕世界Y轴，改变Y轴欧拉角
euler.y += h * _RotateSpeed;
// 垂直旋转：绕自身X轴，改变X轴欧拉角
euler.x += v * _RotateSpeed;
// 限制X轴角度
euler.x = ClampAngle(euler.x, minVerticalAngle, maxVerticalAngle);
transform.eulerAngles = euler;
但是，注意：我们原来的旋转是绕自身X轴，而直接修改欧拉角相当于在同一个变换中旋转，顺序是Unity内部决定的（ZXY）。这样可能会与原来的旋转效果有差异。
另一种方法是：先进行水平旋转（绕世界Y轴），然后进行垂直旋转（绕自身X轴），但使用四元数乘法。这样可以避免万向锁问题，但代码稍复杂。
考虑到简单性，我们使用欧拉角限制。
我们添加两个变量：
public float minVerticalAngle = -30.0f;
public float maxVerticalAngle = 30.0f;
然后修改旋转部分。
但是，注意：我们原来的代码中，水平旋转是绕世界Y轴，垂直旋转是绕自身X轴。而直接修改欧拉角可能会改变旋转顺序，导致旋转效果与原来不同。
为了保持原来的旋转顺序，我们可以使用四元数：
Quaternion originalRotation = transform.rotation;
// 先绕世界Y轴旋转
transform.Rotate(0, h * _RotateSpeed, 0, Space.World);
// 再绕自身X轴旋转，但需要限制
transform.Rotate(v * _RotateSpeed, 0, 0, Space.Self);
然后，我们再限制X轴欧拉角。
但是，这样旋转后，我们再去限制欧拉角，可能会引入抖动？所以，我们可以在旋转后直接修改欧拉角，将X轴限制在范围内。
步骤：
先进行世界Y轴的旋转
再进行自身X轴的旋转
获取欧拉角，限制X轴，然后设置回去。
代码：
if (Input.GetMouseButton(0))
{
float h = -Input.GetAxis("Mouse X");
float v = -Input.GetAxis("Mouse Y");
// 先绕世界Y轴旋转
transform.Rotate(0, h * _RotateSpeed, 0, Space.World);

// 再绕自身X轴旋转
transform.Rotate(v * _RotateSpeed, 0, 0, Space.Self);

// 现在限制X轴旋转角度
Vector3 euler = transform.eulerAngles;
euler.x = ClampAngle(euler.x, minVerticalAngle, maxVerticalAngle);
// 注意：我们可能不希望Z轴有旋转，所以将Z轴设为0
euler.z = 0;
transform.eulerAngles = euler;
}
但是，这样可能会因为旋转顺序问题导致不是完全相同的效果。因为Rotate的旋转顺序和欧拉角转换可能不同。
另一种方法：我们使用一个Vector3来累积旋转，然后应用限制。
我们可以这样：
if (Input.GetMouseButton(0))
{
float h = -Input.GetAxis("Mouse X");
float v = -Input.GetAxis("Mouse Y");
// 获取当前的欧拉角
Vector3 euler = transform.eulerAngles;
// 水平旋转：改变Y轴
euler.y += h * _RotateSpeed;
// 垂直旋转：改变X轴
euler.x += v * _RotateSpeed;
// 限制X轴
euler.x = ClampAngle(euler.x, minVerticalAngle, maxVerticalAngle);
euler.z = 0; // 确保Z轴为0
transform.eulerAngles = euler;
}
这样修改后，旋转顺序是Unity内部决定的（ZXY），但通常这样也能工作。
我们可以尝试这种方法。
我们选择第二种方法，因为代码简单，而且能够限制角度。
但是，注意：欧拉角在0~360，所以ClampAngle方法需要处理。
我们写一个ClampAngle方法，将角度限制在min和max之间，并处理360的循环。
完整的ClampAngle方法：
float ClampAngle(float angle, float min, float max)
{
if (angle < -360) angle += 360;
if (angle > 360) angle -= 360;
return Mathf.Clamp(angle, min, max);
}
但是，注意：Unity的欧拉角返回的是0~360，所以当我们从transform.eulerAngles获取角度时，它是在0~360。而我们的min和max可能是负值，比如-30~30。
所以，我们需要将角度转换为-180~180，然后限制，再转换回0~360？其实ClampAngle方法已经处理了超出-360~360的角度，但我们的限制范围是-30~30，所以我们需要将角度调整到-180~180。
我们可以将角度大于180的减去360，使其变成负值，然后再限制。
修改ClampAngle方法：
float ClampAngle(float angle, float min, float max)
{
// 将角度调整到-180~180范围内
if (angle > 180) angle -= 360;
else if (angle < -180) angle += 360;
// 限制角度
return Mathf.Clamp(angle, min, max);
}
这样，我们就可以将0~360的角度转换为-180~180，然后限制在-30~30之间。
完整代码修改：
我们添加两个变量minVerticalAngle和maxVerticalAngle，并修改旋转部分。
代码如下：

## 2. 相机旋转

下面是修改后的脚本，添加了旋转倾角的范围限制：

```csharp
public class CameraMove : MonoBehaviour
{
    public float _MoveSpeed = 50.0f;
    // 设置移动范围
    public float minX = -400f;
    public float maxX = -209f;
    public float minZ = 0f;
    public float maxZ = 118f;
    public float fixedHeight = 88f;  // 固定高度

    public float _RotateSpeed = 2.0f;
    
    // 新增：旋转倾角限制
    public float minVerticalAngle = -30f;  // 最小俯仰角（向下看的角度）
    public float maxVerticalAngle = 80f;   // 最大俯仰角（向上看的角度）
    
    private Vector3 currentRotation;  // 当前旋转角度

    void Start()
    {
        // 初始化当前旋转角度
        currentRotation = transform.eulerAngles;
    }

    void Update()
    {
        CameraMoveFunc();
    }

    void CameraMoveFunc()
    {
        if (Input.GetMouseButton(1))
        {
            float h = -Input.GetAxis("Mouse X");
            float v = -Input.GetAxis("Mouse Y");
            
            Vector3 rightDir = transform.right;
            rightDir.y = 0;
            rightDir.Normalize();

            Vector3 forwardDir = transform.forward;
            forwardDir.y = 0;
            forwardDir.Normalize();
            
            Vector3 movement = (rightDir * h + forwardDir * v) * _MoveSpeed * Time.deltaTime;
            
            // 计算新位置
            Vector3 newPosition = transform.position + movement;
            
            // 使用Mathf.Clamp限制X和Z坐标范围
            newPosition.x = Mathf.Clamp(newPosition.x, minX, maxX);
            newPosition.z = Mathf.Clamp(newPosition.z, minZ, maxZ);
            newPosition.y = fixedHeight;  // 保持固定高度
            
            transform.position = newPosition;            
        } 
        else if (Input.GetMouseButton(0))
        {
            float h = -Input.GetAxis("Mouse X");
            float v = -Input.GetAxis("Mouse Y");

            // 应用旋转
            currentRotation.y += h * _RotateSpeed;  // 水平旋转（Y轴）
            currentRotation.x -= v * _RotateSpeed;  // 垂直旋转（X轴）
            
            // 限制X轴旋转角度（俯仰角）
            currentRotation.x = Mathf.Clamp(currentRotation.x, minVerticalAngle, maxVerticalAngle);
            
            // 应用限制后的旋转
            transform.rotation = Quaternion.Euler(currentRotation);
        }
    }
}
```

## 替代方案：使用更精确的角度限制

如果你需要更精确的角度控制，可以使用这个版本：

```csharp
public class CameraMove : MonoBehaviour
{
    public float _MoveSpeed = 50.0f;
    // 设置移动范围
    public float minX = -400f;
    public float maxX = -209f;
    public float minZ = 0f;
    public float maxZ = 118f;
    public float fixedHeight = 88f;

    public float _RotateSpeed = 2.0f;
    
    // 旋转倾角限制
    [Header("旋转限制")]
    [Range(-90, 0)]
    public float minVerticalAngle = -30f;  // 最小俯角
    [Range(0, 90)]
    public float maxVerticalAngle = 80f;   // 最大仰角
    
    private float xRotation = 0f;  // X轴旋转角度
    private float yRotation = 0f;  // Y轴旋转角度

    void Start()
    {
        // 初始化旋转角度
        Vector3 currentEuler = transform.eulerAngles;
        xRotation = currentEuler.x;
        yRotation = currentEuler.y;
        
        // 将角度标准化到-180到180范围
        if (xRotation > 180f) xRotation -= 360f;
        if (yRotation > 180f) yRotation -= 360f;
    }

    void Update()
    {
        CameraMoveFunc();
    }

    void CameraMoveFunc()
    {
        if (Input.GetMouseButton(1))
        {
            // 移动逻辑保持不变
            float h = -Input.GetAxis("Mouse X");
            float v = -Input.GetAxis("Mouse Y");
            
            Vector3 rightDir = transform.right;
            rightDir.y = 0;
            rightDir.Normalize();

            Vector3 forwardDir = transform.forward;
            forwardDir.y = 0;
            forwardDir.Normalize();
            
            Vector3 movement = (rightDir * h + forwardDir * v) * _MoveSpeed * Time.deltaTime;
            
            Vector3 newPosition = transform.position + movement;
            newPosition.x = Mathf.Clamp(newPosition.x, minX, maxX);
            newPosition.z = Mathf.Clamp(newPosition.z, minZ, maxZ);
            newPosition.y = fixedHeight;
            
            transform.position = newPosition;            
        } 
        else if (Input.GetMouseButton(0))
        {
            float mouseX = -Input.GetAxis("Mouse X") * _Rotate速度;
            float mouseY = -Input.GetAxis("Mouse Y") * _Rotate速度;

            // 更新旋转角度
            yRotation += mouseX;  // 水平旋转
            xRotation += mouseY;  // 垂直旋转
            
            // 限制垂直旋转角度
            xRotation = Mathf.Clamp(xRotation, minVerticalAngle, maxVerticalAngle);
            
            // 应用旋转
            transform.rotation = Quaternion.Euler(xRotation, yRotation, 0f);
        }
    }
    
    // 公共方法：重置相机角度到默认
    public void ResetCameraRotation()
    {
        xRotation = 0f;
        yRotation = 0f;
        transform.rotation = Quaternion.Euler(xRotation, yRotation, 0f);
    }
    
    // 公共方法：设置特定角度
    public void SetCameraRotation(float xAngle, float yAngle)
    {
        xRotation = Mathf.Clamp(xAngle, minVerticalAngle, maxVerticalAngle);
        yRotation = yAngle;
        transform.rotation = Quaternion.Euler(xRotation, yRotation, 0f);
    }
}
```

## 高级版本：支持平滑插值和更多控制

```csharp
public class AdvancedCameraMove : MonoBehaviour
{
    [Header("移动设置")]
    public float _MoveSpeed = 50.0f;
    public float minX = -400f, maxX = -209f;
    public float minZ = 0f, maxZ = 118f;
    public float fixedHeight = 88f;

    [Header("旋转设置")]
    public float _RotateSpeed = 2.0f;
    public float rotationSmoothing = 5f;  // 旋转平滑度
    
    [Header("旋转限制")]
    [SerializeField] private float minVerticalAngle = -30f;
    [SerializeField] private float maxVerticalAngle = 80f;
    
    private float targetXRotation = 0f;
    private float targetYRotation = 0f;
    private float currentXRotation = 0f;
    private float currentYRotation = 0f;

    void Start()
    {
        Vector3 currentEuler = transform.eulerAngles;
        targetXRotation = currentEuler.x;
        targetYRotation = currentEuler.y;
        currentXRotation = targetXRotation;
        currentYRotation = targetYRotation;
        
        // 标准化角度
        if (targetXRotation > 180f) targetXRotation -= 360f;
        if (targetYRotation > 180f) targetYRotation -= 360f;
    }

    void Update()
    {
        HandleCameraMovement();
        HandleCameraRotation();
        ApplySmoothRotation();
    }

    void HandleCameraMovement()
    {
        if (Input.GetMouseButton(1))
        {
            float h = -Input.GetAxis("Mouse X");
            float v = -Input.GetAxis("Mouse Y");
            
            Vector3 rightDir = transform.right;
            rightDir.y = 0;
            rightDir.Normalize();

            Vector3 forwardDir = transform.forward;
            forwardDir.y = 0;
            forwardDir.Normalize();
            
            Vector3 movement = (rightDir * h + forwardDir * v) * _MoveSpeed * Time.deltaTime;
            
            Vector3 newPosition = transform.position + movement;
            newPosition.x = Mathf.Clamp(newPosition.x, minX, maxX);
            newPosition.z = Mathf.Clamp(newPosition.z, minZ, maxZ);
            newPosition.y = fixedHeight;
            
            transform.position = newPosition;
        }
    }

    void HandleCameraRotation()
    {
        if (Input.GetMouseButton(0))
        {
            float mouseX = -Input.GetAxis("Mouse X") * _RotateSpeed;
            float mouseY = -Input.GetAxis("Mouse Y") * _RotateSpeed;

            targetYRotation += mouseX;
            targetXRotation += mouseY;
            
            // 限制角度
            targetXRotation = Mathf.Clamp(targetXRotation, minVerticalAngle, maxVerticalAngle);
        }
    }
    
    void ApplySmoothRotation()
    {
        // 平滑插值
        currentXRotation = Mathf.Lerp(currentXRotation, targetXRotation, rotationSmoothing * Time.deltaTime);
        currentYRotation = Mathf.Lerp(currentYRotation, targetYRotation, rotationSmoothing * Time.deltaTime);
        
        transform.rotation = Quaternion.Euler(currentXRotation, currentYRotation, 0f);
    }
    
    // 调试信息
    void OnGUI()
    {
        GUILayout.Label($"相机角度: X={currentXRotation:F1}°, Y={currentYRotation:F1}°");
        GUILayout.Label($"角度限制: {minVerticalAngle}° 到 {maxVerticalAngle}°");
    }
}
```

## 主要修改说明

### 1. **角度限制核心代码**
```csharp
// 限制X轴旋转角度（关键修改）
currentRotation.x = Mathf.Clamp(currentRotation.x, minVerticalAngle, maxVerticalAngle);
```

### 2. **推荐的角度范围**
- **minVerticalAngle**: -30° 到 0°（向下看的限制）
- **maxVerticalAngle**: 60° 到 80°（向上看的限制）

### 3. **使用建议**
- 如果相机是**第一人称**视角，建议范围：`-30° 到 60°`
- 如果相机是**第三人称**视角，建议范围：`-10° 到 80°`
- 如果相机是**俯视**视角，建议范围：`30° 到 80°`

### 4. **Inspector 中的配置**
在 Unity Inspector 中，你可以这样设置：
```
Min Vertical Angle: -30
Max Vertical Angle: 80
```

这样修改后，相机的上下俯仰角度就会被限制在你设定的范围内，防止相机过度旋转造成不自然的视角。
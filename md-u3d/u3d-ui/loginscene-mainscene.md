# 1. 一个unity工程2个场景，一个是loginscene，一个是mainscene，如何设置

以下是两个场景（LoginScene 和 MainScene）的完整设置方案：

## 1. 场景结构设置

### Build Settings 配置
```bash
# Build Settings 中的场景顺序
Scenes In Build:
0: Assets/Scenes/LoginScene.unity    # 登录场景（启动场景）
1: Assets/Scenes/MainScene.unity      # 主场景
```

### 设置方法：
```bash
File → Build Settings → 拖拽场景到列表
确保 LoginScene 在索引 0 的位置
```

## 2. LoginScene 配置

### 场景结构
```bash
LoginScene/
├── Main Camera
├── EventSystem
└── Canvas/
    ├── LoginPanel (激活)
    │   ├── Background (Image)
    │   ├── TitleText
    │   ├── UsernameInput
    │   ├── PasswordInput  
    │   ├── LoginButton
    │   ├── RegisterButton
    │   └── MessageText
    └── RegisterPanel (禁用)
```

### 登录脚本（LoginManager.cs）
```csharp
using UnityEngine;
using UnityEngine.UI;
using UnityEngine.SceneManagement;

public class LoginManager : MonoBehaviour
{
    [Header("UI引用")]
    public GameObject loginPanel;
    public GameObject registerPanel;
    public InputField usernameInput;
    public InputField passwordInput;
    public Text messageText;
    
    [Header("场景设置")]
    public string mainSceneName = "MainScene";
    
    void Start()
    {
        // 确保显示登录面板
        ShowLoginPanel();
        
        // 检查是否已登录（自动登录）
        CheckAutoLogin();
    }
    
    public void OnLoginButtonClicked()
    {
        string username = usernameInput.text.Trim();
        string password = passwordInput.text;
        
        if (AuthenticateUser(username, password))
        {
            // 保存登录状态
            PlayerPrefs.SetString("Username", username);
            PlayerPrefs.SetInt("IsLoggedIn", 1);
            PlayerPrefs.Save();
            
            // 跳转到主场景
            SceneManager.LoadScene(mainSceneName);
        }
        else
        {
            ShowMessage("用户名或密码错误！", Color.red);
        }
    }
    
    bool AuthenticateUser(string username, string password)
    {
        // 简单验证（实际项目用数据库）
        return username == "admin" && password == "123456";
    }
    
    void CheckAutoLogin()
    {
        if (PlayerPrefs.GetInt("IsLoggedIn", 0) == 1)
        {
            // 自动跳转到主场景
            SceneManager.LoadScene(mainSceneName);
        }
    }
    
    void ShowMessage(string msg, Color color) { /* 实现消息显示 */ }
    public void ShowLoginPanel() { /* 切换面板 */ }
    public void ShowRegisterPanel() { /* 切换面板 */ }
}
```

## 3. MainScene 配置

### 场景结构
```bash
MainScene/
├── Main Camera
├── EventSystem
├── Directional Light
└── Canvas/
    ├── MainUI/
    │   ├── Header/
    │   │   ├── UserInfoText
    │   │   └── LogoutButton
    │   └── ContentPanel
    └── 3D内容或其他游戏对象
```

### 主场景管理器（MainSceneManager.cs）
```csharp
using UnityEngine;
using UnityEngine.UI;
using UnityEngine.SceneManagement;

public class MainSceneManager : MonoBehaviour
{
    [Header("UI引用")]
    public Text userInfoText;
    public Button logoutButton;
    
    void Start()
    {
        // 显示用户信息
        string username = PlayerPrefs.GetString("Username", "游客");
        userInfoText.text = $"欢迎, {username}";
        
        // 绑定退出事件
        logoutButton.onClick.AddListener(OnLogout);
    }
    
    void OnLogout()
    {
        // 清除登录状态
        PlayerPrefs.DeleteKey("IsLoggedIn");
        PlayerPrefs.DeleteKey("Username");
        PlayerPrefs.Save();
        
        // 返回登录场景
        SceneManager.LoadScene("LoginScene");
    }
    
    void Update()
    {
        // ESC键退出
        if (Input.GetKeyDown(KeyCode.Escape))
        {
            OnLogout();
        }
    }
}
```

## 4. 场景切换管理器

### SceneLoader.cs（可选）
```csharp
using UnityEngine;
using UnityEngine.SceneManagement;
using UnityEngine.UI;

public class SceneLoader : MonoBehaviour
{
    public static SceneLoader Instance;
    
    [Header("加载界面")]
    public GameObject loadingScreen;
    public Slider progressBar;
    public Text progressText;
    
    void Awake()
    {
        if (Instance == null)
        {
            Instance = this;
            DontDestroyOnLoad(gameObject);
        }
        else
        {
            Destroy(gameObject);
        }
    }
    
    public void LoadScene(string sceneName)
    {
        StartCoroutine(LoadSceneAsync(sceneName));
    }
    
    System.Collections.IEnumerator LoadSceneAsync(string sceneName)
    {
        loadingScreen.SetActive(true);
        
        AsyncOperation operation = SceneManager.LoadSceneAsync(sceneName);
        operation.allowSceneActivation = false;
        
        while (!operation.isDone)
        {
            float progress = Mathf.Clamp01(operation.progress / 0.9f);
            progressBar.value = progress;
            progressText.text = $"加载中... {progress * 100}%";
            
            if (operation.progress >= 0.9f)
            {
                progressText.text = "按任意键继续";
                if (Input.anyKeyDown)
                    operation.allowSceneActivation = true;
            }
            
            yield return null;
        }
        
        loadingScreen.SetActive(false);
    }
}
```

## 5. 项目设置步骤

### 步骤1：创建场景文件夹结构
```bash
Assets/
├── Scenes/
│   ├── LoginScene.unity
│   └── MainScene.unity
├── Scripts/
│   ├── UI/
│   │   ├── LoginManager.cs
│   │   └── MainSceneManager.cs
│   └── Utilities/
│       └── SceneLoader.cs
└── Prefabs/
    └── UI/
        ├── LoginUI.prefab
        └── MainUI.prefab
```

### 步骤2：配置Build Settings
```csharp
// 编辑器脚本自动配置
#if UNITY_EDITOR
using UnityEditor;
using UnityEditor.SceneManagement;

public class SceneSetup : EditorWindow
{
    [MenuItem("Tools/场景设置/配置构建场景")]
    static void SetupBuildScenes()
    {
        // 获取场景路径
        string loginScenePath = "Assets/Scenes/LoginScene.unity";
        string mainScenePath = "Assets/Scenes/MainScene.unity";
        
        // 创建场景列表
        EditorBuildSettingsScene[] scenes = new EditorBuildSettingsScene[]
        {
            new EditorBuildSettingsScene(loginScenePath, true),
            new EditorBuildSettingsScene(mainScenePath, true)
        };
        
        // 设置构建场景
        EditorBuildSettings.scenes = scenes;
        Debug.Log("构建场景配置完成！");
    }
    
    [MenuItem("Tools/场景设置/打开登录场景")]
    static void OpenLoginScene()
    {
        EditorSceneManager.OpenScene("Assets/Scenes/LoginScene.unity");
    }
    
    [MenuItem("Tools/场景设置/打开主场景")]
    static void OpenMainScene()
    {
        EditorSceneManager.OpenScene("Assets/Scenes/MainScene.unity");
    }
}
#endif
```

### 步骤3：设置场景加载顺序
```csharp
// 在LoginScene的某个GameObject上添加
public class StartupManager : MonoBehaviour
{
    void Start()
    {
        // 确保游戏以正确设置启动
        Application.runInBackground = true;
        Screen.sleepTimeout = SleepTimeout.NeverSleep;
        
        // 初始化游戏管理器
        if (GameManager.Instance == null)
        {
            Instantiate(Resources.Load<GameObject>("Managers/GameManager"));
        }
    }
}
```

## 6. 完整的登录验证流程

### GameManager.cs（持久化对象）
```csharp
using UnityEngine;
using UnityEngine.SceneManagement;

public class GameManager : MonoBehaviour
{
    public static GameManager Instance;
    
    public string currentUser { get; private set; }
    public bool isLoggedIn { get; private set; }
    
    void Awake()
    {
        if (Instance == null)
        {
            Instance = this;
            DontDestroyOnLoad(gameObject);
            
            // 加载保存的用户数据
            LoadUserData();
            
            // 检查是否需要自动登录
            CheckAutoLogin();
        }
        else
        {
            Destroy(gameObject);
        }
    }
    
    void LoadUserData()
    {
        currentUser = PlayerPrefs.GetString("CurrentUser", "");
        isLoggedIn = PlayerPrefs.GetInt("IsLoggedIn", 0) == 1;
    }
    
    void CheckAutoLogin()
    {
        if (isLoggedIn && SceneManager.GetActiveScene().name == "LoginScene")
        {
            // 自动跳转到主场景
            SceneManager.LoadScene("MainScene");
        }
    }
    
    public void Login(string username)
    {
        currentUser = username;
        isLoggedIn = true;
        
        PlayerPrefs.SetString("CurrentUser", username);
        PlayerPrefs.SetInt("IsLoggedIn", 1);
        PlayerPrefs.Save();
        
        SceneManager.LoadScene("MainScene");
    }
    
    public void Logout()
    {
        currentUser = "";
        isLoggedIn = false;
        
        PlayerPrefs.DeleteKey("CurrentUser");
        PlayerPrefs.DeleteKey("IsLoggedIn");
        PlayerPrefs.Save();
        
        SceneManager.LoadScene("LoginScene");
    }
}
```

## 7. 测试和调试

### 调试脚本
```csharp
using UnityEngine;

public class SceneDebugger : MonoBehaviour
{
    void Update()
    {
        // 快捷键调试
        if (Input.GetKeyDown(KeyCode.F1))
        {
            // 快速切换到主场景（测试用）
            SceneManager.LoadScene("MainScene");
        }
        
        if (Input.GetKeyDown(KeyCode.F2))
        {
            // 快速返回登录场景
            SceneManager.LoadScene("LoginScene");
        }
        
        if (Input.GetKeyDown(KeyCode.F3))
        {
            // 打印当前场景信息
            Debug.Log($"当前场景: {SceneManager.GetActiveScene().name}");
            Debug.Log($"用户状态: {(GameManager.Instance.isLoggedIn ? "已登录" : "未登录")}");
        }
    }
}
```

## 8. 最终检查清单

### 配置验证
```bash
✅ Build Settings 中包含两个场景
✅ LoginScene 在索引 0 的位置  
✅ 场景路径正确无误
✅ 场景管理器脚本正确挂载
✅ UI 组件引用正确设置
✅ PlayerPrefs 键名一致
```

这样设置后，你的两个场景就能正确配合工作：启动时进入登录场景，登录成功后跳转到主场景，退出后返回登录场景。
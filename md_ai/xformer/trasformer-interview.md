# 1.字节跳动Transformer的面试难度

## 一、基础原理与数学模型（21题
1.Transformer为何使用多头注意力机制?（为什么不用一个头)
2.Transformer为什么Q和K使用不同的权重矩阵生成?为
何不能使用同一个值进行自身的点乘?（注意和第一个问题的区别)
3.Transformer计算attention的时候为何选择点乘而不
是加法?两者计算复杂度和效果上有什么区别？
4.为什么在进行softmax之前需要对attention进行scaled?(为什么除以dk的平方根)，并使用公式推导进行讲解
5.在计算attention score的时候如何对padding做mask操作?
6.为什么在进行多头注意力的时候需要对每个head进行降维?
7.讲一下Transformer的Encoder模块?
8.为何在获取输入词向量之后需要对矩阵乘以embeddingsize的开方？

9.简单介绍Transformer的位置编码？
10.了解哪些关于位置编码的技术？
11.简单讲一下Transformer中的残差结构以及意义。
12.为什么transformer块使用LayerNorm而不是BatchNorm?
13.讲一下BatchNorm技术及其优缺点？
14.简单描述-下Transformer中的前馈神经网络?使用了什么激活函数?相关优缺点?Encoder端和Decoder端是如
何进行交互的？
15.Encoder端和Decoder端是如何进行交互的?（在这里可以问一下关于seq2seq的attention知识)
16.Transformer的并行化提现在哪个地方?Decoder端可以做并行化吗?
17.描述-下wordpiece model和 byte pair encoding?Dropout是如何设定的，位置在哪里?Dropout在测试的
需要有什么需要注意的吗?18.Transformer训练的时候学习率是如何设定的？
19.Dropout是如何设定的?
20.Bert的mask为何不学习transformer在attention处屏蔽score的技巧？ 

## 训练与优化（19题
1.Transformer中的可训练Queries、 Keys和Values矩
阵从哪儿来?2.Transformer的FeedForward层在训练的
时候到底在训练什么？
3.具体分析Transformer的Embeddings层、Attention
层和Feedforward层的复杂度。
4.Transformer的PositionalEncoding如何表达相对位
置关系？
5.LayerNormalization蕴含的神经网络的假设是什么?
6.从数据的角度分析Transformer中的Decoder和
Encoder的依存关系。
7.描述Transformer中的Tokenization的数学原理、运
行流程、问题及改进方法。
8.描述把self-attention复杂度从O(n ^2)降低到O(n)的方
案。
9.Bert的CLS能够有效的表达SentenceEmbeddings吗?
10.使用BPE进行Tokenization对于Cross-lingual语言模
型的意义?
11.如何训练Transformer处理数据量差异大的多类别数据？

12.如何使用多种类小样本对Transformer训练取得好的分
类效果?
13.在输入Embeddings时是否可以使用多方来源的词嵌
入？
14.更深更宽的Transformer网络是否意味着更强的预训练
模型？
15.如何降低Transformer中Embedding中的参数数量?
16.描述Trasnformer不同Layer之间的FeedForward神
经网络之间的联系。
17.如何降低Transformer的Feedforward层的参数数量?
18.Transformer的Layer深度过深会可能导致什么现象?
19.如何大规模降低Transformer中Embedding中的参数数量?
## 三、应用与实践（6题
1.如何使用Transformer实现Zero-shot Learning?
2.描述至少2种对不同训练模型训练出来的Embeddings进
行相似度比较的方法
3.如何使得小模型例如LSTM具有大模型例如Bert的能力?
实很有难度 

4.训练后的BERT模型泛化能力的限制是什么？
5.GPT的auto-regressive语言模型架构在信息表示方面有
什么缺陷？
6.描述BERT中MLM实现中的缺陷及可能的解决方案。
## 四、技术深入与创新应用（29题
1.从数学角度阐明对Transformer任意位置和长度进行Mask的方式。
2.描述Encoder和Decoder中Attention机制的不同之处。
3.描述Transformer中Decoder的Embedding layers架构设计、运行流程和数学原理。
4.描述Transformer进行Training的全生命周期的在Decoder中是如何进行Embedding的。
5.描述Transformer进行Inference的全生命周期的在Decoder中是如何进行Embedding的。
6.如果Transformer采用和Inference同样的流程进行Training，会有什么弊端?
7.为何Transformer的Matrix Dimensions是3D的?
8.描述只由一个Encoder和Decoder的Transformer使
用了Attention的地方及其功能。
9.描述Training和Inference时Masking在
Transformer使用Attention机制的地方号市的功能和数
学实现。
10.描述Transformer的TrainingLoss工作流程和数学
公式。
11.阐述Multi-head Attention机制中通过Linear
layer计算QKV的logical和.physical partition.
12.阐述Transformer中所有可训练操作的功能。
13.阐述QKV在Transformer中的功能。
14.解释Transformer中Attention Score衡量不同
WordsRelevance的原理
15.描述Transformer如何知道什么样的Weights能更好
地表达不同信息部分的注意力。
16.如何减少Transformer中训练后的Word
Embeddings的Bias?
17.解决Self-attention和Word与自身Attention的问
题?
18.Transformer如何有效表示NLP、CV等AI领域的信息

19.通过GroundTruth训练Transformer使其具有泛化
能力的原因？
20.Transformer的Attention计算时为何需要进行
Scaling?
21.输入文本词汇的顺序如何由position éncoding或
multi-headattention实现?
22.描述multi-headattention的实现方式。
23.描述Transformer中non-linear操作的类型和数学原
理。
24.为何Transformer论文作者声称"Attention is all you need"?
25.谈一下Teacherforcing的数学原理及其在Transformer中的应用。

## 五、性能优化与模型改进（7题
1.Transformer采用Inference流程进行Training的问题?
2.Transformer的MatrixDimensions为何是3D的?
3.描述单Encoder和Decoder的Transformer使用Attention的地方及其功能。 
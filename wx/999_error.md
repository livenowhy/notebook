# 微信开发

## 40033 错误

    {'errcode': 40033, 'errmsg': 'invalid charset. please check your request, if include \\uxxxx will create fail! hint: [s51DMA08921891]'}

    利用 Python 的 json 内置模块, 在进行 dumps 操作时, 使用 ensure_ascii=False 参数是中文不会被转码
    解决: data = json.dumps(data,ensure_ascii=False).encode('utf-8')
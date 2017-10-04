apple_library(
  name = 'Home',
  visibility = ['PUBLIC'],
  srcs = glob(['source/*.swift']),
  )

apple_binary(
    name = 'main',
    deps = [
        ':Home',
    ],
    frameworks = [
        '$SDKROOT/System/Library/Frameworks/Foundation.framework',
    ],
)

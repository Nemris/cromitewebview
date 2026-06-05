# Cromite Webview Magisk Module Generator

This is a generator that creates a minimal Magisk module to install [Cromite]'s Webview.

I made it for my own use case, which is not guaranteed to correspond to yours, therefore the
resulting module is simple by design. Due to this, it might not be appropriate for your own device.

## Can I install the module?

That depends on your Android OS' configuration. For more information, refer to the [Bromite Wiki]'s
steps for how to verify whether you can install an alternative Webview.

Keep in mind that Cromite Webview's package name is `com.android.webview`, therefore that will be
the package name you need to look for while following the instructions above.

## Building the module

To build the module, you'll need `make`, `curl`, `zip` and an internet connection.

Then, you can either `git clone` this repo or download the code via the web UI.

Afterwards, simply execute `make`, which will download the Cromite Webview release and put the
finished module in the `out` directory.

## License

This generator is licensed under the terms of the MIT license.

Check [LICENSE] for further info.

[Cromite]:https://github.com/uazo/cromite
[Bromite Wiki]:https://github.com/bromite/bromite/wiki/Installing-SystemWebView#verifying-allowed-systemwebview-packages
[LICENSE]:./LICENSE

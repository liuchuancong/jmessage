package liu.chat.com.chat;
import android.content.Intent;
import android.os.Bundle;
import im.sdk.debug.activity.RegisterAndLoginActivity;
import io.flutter.app.FlutterActivity;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugins.GeneratedPluginRegistrant;
import cn.jpush.im.android.api.JMessageClient;
public class MainActivity extends FlutterActivity {
  private static final String CHANNEL = "chat/jmessage";
  @Override
  protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    GeneratedPluginRegistrant.registerWith(this);
    new MethodChannel(getFlutterView(),CHANNEL).setMethodCallHandler(new MethodCallHandler() {
      @Override
      public void onMethodCall(MethodCall methodCall, Result result) {
        if(methodCall.method.equals("openJmessage")){
//          Intent intent = new Intent(MainActivity.this, RegisterAndLoginActivity.class);
          Intent intent = new Intent();
          intent.setClass(MainActivity.this,RegisterAndLoginActivity.class);
          startActivity(intent);
          result.success("success");
        }else if(methodCall.method.equals("initJmessage")){
          initJmessage();
          result.success("success");
        }

        else {
          result.notImplemented();
        }
      }
    });
  }
  private void initJmessage(){
    JMessageClient.setDebugMode(true);
    JMessageClient.init(this);
  }
}

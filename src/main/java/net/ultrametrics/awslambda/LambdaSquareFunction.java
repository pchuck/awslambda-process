
package net.ultrametrics.awslambda;

import com.amazonaws.services.lambda.runtime.Context;
import com.amazonaws.services.lambda.runtime.LambdaLogger;

public class LambdaSquareFunction {
  public String myHandler(int a, Context context) {
    LambdaLogger logger = context.getLogger();
    logger.log("received : " + a);
    double square = Math.pow(a, 2);
    return String.valueOf(square);
  }
}


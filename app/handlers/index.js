const { IAMClient } = require("@aws-sdk/client-iam");
const client = new IAMClient({ region: "us-east-1" });

module.exports.rotateSecretAccessKeys = async (event) => {
  const params = {
    /* Your params values will go in here */
  };

  try {
    const response = await client.send(/* Your command will go in here */);
  } catch (error) {
    console.log("Error:", error);
  }
};

const {
  IAMClient,
  CreateAccessKeyCommand,
  ListAccessKeysCommand,
  GetAccessKeyLastUsedCommand,
  DeleteAccessKeyCommand,
} = require("@aws-sdk/client-iam");
const client = new IAMClient({ region: "us-east-1" });

module.exports.rotateSecretAccessKeys = async (event) => {
  try {
    // List all the IAM users in the account
    const listUsersResponse = await client.send(new ListUsersCommand({}));

    for (const user of listUsersResponse.Users) {
    const params = {
      UserName: user.UserName,
    };

    // Delete the access keys
    const deleteParams = {
      AccessKeyId: accessKeyId,
      UserName: params.UserName,
    };

    await client.send(new DeleteAccessKeyCommand(deleteParams));
    console.log(
      `Access key deleted for user ${params.UserName}: ${accessKeyId}`
    );

    // Create a new access key for the specified IAM user
    const createResponse = await client.send(
      new CreateAccessKeyCommand(params)
    );
    const accessKeyId = createResponse.AccessKey.AccessKeyId;
    const secretAccessKey = createResponse.AccessKey.SecretAccessKey;

    console.log(
      `Access key created for user ${params.UserName}: ${accessKeyId}`
    );
    }

    return "Success";
  } catch (error) {
    console.log("Error:", error);
    return "Error";
  }
};

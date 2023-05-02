const {
  IAMClient,
  CreateAccessKeyCommand,
  ListAccessKeysCommand,
  DeleteAccessKeyCommand,
  ListUsersCommand,
  GetUserCommand,
} = require("@aws-sdk/client-iam");

const { SESClient, SendEmailCommand } = require("@aws-sdk/client-ses");

const client = new IAMClient({ region: "us-east-1" });
const sesClient = new SESClient({ region: "us-east-1" });
//used this email for testing purposes
const adminEmail = "mxolisi.tshezi@batsamayi.com";

module.exports.rotateSecretAccessKeys = async (event) => {
  try {
    // List all the IAM users in the account
    const listUsersResponse = await client.send(new ListUsersCommand({}));

    for (const user of listUsersResponse.Users) {
      // List all access access to get username and accessKey id
      const accessKeysResponse = await client.send(
        new ListAccessKeysCommand({ UserName: user.UserName })
      );

      // Loop through the user's access keys and delete them
      for (const accessKey of accessKeysResponse.AccessKeyMetadata) {
        const deleteParams = {
          AccessKeyId: accessKey.AccessKeyId,
          UserName: user.UserName,
        };

        // Delete access keys command
        await client.send(new DeleteAccessKeyCommand(deleteParams));

        console.log(
          `Access key deleted for user ${user.UserName}: ${accessKey.AccessKeyId}`
        );
      }

      // Create a new access key for the specified IAM user
      const createResponse = await client.send(
        new CreateAccessKeyCommand({ UserName: user.UserName })
      );

      const accessKeyId = createResponse.AccessKey.AccessKeyId;
      const secretAccessKey = createResponse.AccessKey.SecretAccessKey;

      console.log(
        `Access key created for user ${user.UserName}: ${accessKeyId}`
      );

      // Send an email to the admin email with the new access key details
      const getUserResponse = await client.send(
        new GetUserCommand({ UserName: user.UserName })
      );
      const userEmail = getUserResponse.User.Email;

      const emailParams = {
        Destination: {
          ToAddresses: [adminEmail],
        },
        Message: {
          Body: {
            Text: {
              Charset: "UTF-8",
              Data: `A new IAM Access Key ID has been created for user ${user.UserName}.\nAccess Key ID: ${accessKeyId}\nSecret Access Key: ${secretAccessKey}\nUser Email: ${userEmail}`,
            },
          },
          Subject: {
            Charset: "UTF-8",
            Data: `New AWS IAM Access Key Created for User ${user.UserName}`,
          },
        },
        //used this email for testing purposes

        Source: "mxolisi.tshezi@batsamayi.com",
      };

      await sesClient.send(new SendEmailCommand(emailParams));
    }
  } catch (error) {
    console.log("Error:", error);
    return "Error";
  }
};

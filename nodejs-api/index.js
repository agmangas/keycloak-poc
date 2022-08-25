const session = require("express-session");
const Keycloak = require("keycloak-connect");
const express = require("express");
const bodyParser = require("body-parser");
const cors = require("cors");

const app = express();

app.use(bodyParser.json());
app.use(cors());

const memoryStore = new session.MemoryStore();

app.use(
  session({
    secret: process.env.SESSION_SECRET || "mySecret",
    resave: false,
    saveUninitialized: true,
    store: memoryStore,
  })
);

const keycloak = new Keycloak({ store: memoryStore });

/**
 * When running an Express app behind a reverse proxy,
 * some of the Express APIs may return different values than expected.
 * In order to adjust for this, the trust proxy application setting may be
 * used to expose information provided by the reverse proxy in the Express APIs.
 * The most common issue is express APIs that expose the client’s IP address may
 * instead show an internal IP address of the reverse proxy.
 */
app.set("trust proxy", true);

app.use(keycloak.middleware());

app.get("/api/public", function (_req, res) {
  res.json({ message: "public" });
});

const CLIENT_NAME = "poc-client-default";
const CLIENT_ROLE = "custom_client_role";
const REALM_ROLE = "the_group_role";

app.get(
  "/api/protected",
  keycloak.protect((token) => {
    console.log("token.content", token.content);

    return (
      token.hasApplicationRole(CLIENT_NAME, CLIENT_ROLE) &&
      token.hasRealmRole(REALM_ROLE) &&
      token.hasRole(`${CLIENT_NAME}:${CLIENT_ROLE}`) &&
      token.hasRole(CLIENT_ROLE) &&
      token.hasRole(`realm:${REALM_ROLE}`)
    );
  }),
  function (req, res) {
    console.log(
      "req.kauth.grant.access_token.content",
      req.kauth.grant.access_token.content
    );

    res.json({ message: "secured" });
  }
);

app.use("*", function (_req, res) {
  res.send("<h1>Not found</h1>");
});

app.listen(3000, function () {
  console.log("App listening on port 3000");
});

--
-- PostgreSQL database dump
--

-- Dumped from database version 10.21 (Debian 10.21-1.pgdg110+1)
-- Dumped by pg_dump version 10.21 (Debian 10.21-1.pgdg110+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: keycloak_poc; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE keycloak_poc WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'en_US.utf8' LC_CTYPE = 'en_US.utf8';


ALTER DATABASE keycloak_poc OWNER TO postgres;

\connect keycloak_poc

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: admin_event_entity; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.admin_event_entity (
    id character varying(36) NOT NULL,
    admin_event_time bigint,
    realm_id character varying(255),
    operation_type character varying(255),
    auth_realm_id character varying(255),
    auth_client_id character varying(255),
    auth_user_id character varying(255),
    ip_address character varying(255),
    resource_path character varying(2550),
    representation text,
    error character varying(255),
    resource_type character varying(64)
);


ALTER TABLE public.admin_event_entity OWNER TO postgres;

--
-- Name: associated_policy; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.associated_policy (
    policy_id character varying(36) NOT NULL,
    associated_policy_id character varying(36) NOT NULL
);


ALTER TABLE public.associated_policy OWNER TO postgres;

--
-- Name: authentication_execution; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.authentication_execution (
    id character varying(36) NOT NULL,
    alias character varying(255),
    authenticator character varying(36),
    realm_id character varying(36),
    flow_id character varying(36),
    requirement integer,
    priority integer,
    authenticator_flow boolean DEFAULT false NOT NULL,
    auth_flow_id character varying(36),
    auth_config character varying(36)
);


ALTER TABLE public.authentication_execution OWNER TO postgres;

--
-- Name: authentication_flow; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.authentication_flow (
    id character varying(36) NOT NULL,
    alias character varying(255),
    description character varying(255),
    realm_id character varying(36),
    provider_id character varying(36) DEFAULT 'basic-flow'::character varying NOT NULL,
    top_level boolean DEFAULT false NOT NULL,
    built_in boolean DEFAULT false NOT NULL
);


ALTER TABLE public.authentication_flow OWNER TO postgres;

--
-- Name: authenticator_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.authenticator_config (
    id character varying(36) NOT NULL,
    alias character varying(255),
    realm_id character varying(36)
);


ALTER TABLE public.authenticator_config OWNER TO postgres;

--
-- Name: authenticator_config_entry; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.authenticator_config_entry (
    authenticator_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.authenticator_config_entry OWNER TO postgres;

--
-- Name: broker_link; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.broker_link (
    identity_provider character varying(255) NOT NULL,
    storage_provider_id character varying(255),
    realm_id character varying(36) NOT NULL,
    broker_user_id character varying(255),
    broker_username character varying(255),
    token text,
    user_id character varying(255) NOT NULL
);


ALTER TABLE public.broker_link OWNER TO postgres;

--
-- Name: client; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client (
    id character varying(36) NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    full_scope_allowed boolean DEFAULT false NOT NULL,
    client_id character varying(255),
    not_before integer,
    public_client boolean DEFAULT false NOT NULL,
    secret character varying(255),
    base_url character varying(255),
    bearer_only boolean DEFAULT false NOT NULL,
    management_url character varying(255),
    surrogate_auth_required boolean DEFAULT false NOT NULL,
    realm_id character varying(36),
    protocol character varying(255),
    node_rereg_timeout integer DEFAULT 0,
    frontchannel_logout boolean DEFAULT false NOT NULL,
    consent_required boolean DEFAULT false NOT NULL,
    name character varying(255),
    service_accounts_enabled boolean DEFAULT false NOT NULL,
    client_authenticator_type character varying(255),
    root_url character varying(255),
    description character varying(255),
    registration_token character varying(255),
    standard_flow_enabled boolean DEFAULT true NOT NULL,
    implicit_flow_enabled boolean DEFAULT false NOT NULL,
    direct_access_grants_enabled boolean DEFAULT false NOT NULL,
    always_display_in_console boolean DEFAULT false NOT NULL
);


ALTER TABLE public.client OWNER TO postgres;

--
-- Name: client_attributes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_attributes (
    client_id character varying(36) NOT NULL,
    value character varying(4000),
    name character varying(255) NOT NULL
);


ALTER TABLE public.client_attributes OWNER TO postgres;

--
-- Name: client_auth_flow_bindings; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_auth_flow_bindings (
    client_id character varying(36) NOT NULL,
    flow_id character varying(36),
    binding_name character varying(255) NOT NULL
);


ALTER TABLE public.client_auth_flow_bindings OWNER TO postgres;

--
-- Name: client_initial_access; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_initial_access (
    id character varying(36) NOT NULL,
    realm_id character varying(36) NOT NULL,
    "timestamp" integer,
    expiration integer,
    count integer,
    remaining_count integer
);


ALTER TABLE public.client_initial_access OWNER TO postgres;

--
-- Name: client_node_registrations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_node_registrations (
    client_id character varying(36) NOT NULL,
    value integer,
    name character varying(255) NOT NULL
);


ALTER TABLE public.client_node_registrations OWNER TO postgres;

--
-- Name: client_scope; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_scope (
    id character varying(36) NOT NULL,
    name character varying(255),
    realm_id character varying(36),
    description character varying(255),
    protocol character varying(255)
);


ALTER TABLE public.client_scope OWNER TO postgres;

--
-- Name: client_scope_attributes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_scope_attributes (
    scope_id character varying(36) NOT NULL,
    value character varying(2048),
    name character varying(255) NOT NULL
);


ALTER TABLE public.client_scope_attributes OWNER TO postgres;

--
-- Name: client_scope_client; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_scope_client (
    client_id character varying(255) NOT NULL,
    scope_id character varying(255) NOT NULL,
    default_scope boolean DEFAULT false NOT NULL
);


ALTER TABLE public.client_scope_client OWNER TO postgres;

--
-- Name: client_scope_role_mapping; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_scope_role_mapping (
    scope_id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL
);


ALTER TABLE public.client_scope_role_mapping OWNER TO postgres;

--
-- Name: client_session; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_session (
    id character varying(36) NOT NULL,
    client_id character varying(36),
    redirect_uri character varying(255),
    state character varying(255),
    "timestamp" integer,
    session_id character varying(36),
    auth_method character varying(255),
    realm_id character varying(255),
    auth_user_id character varying(36),
    current_action character varying(36)
);


ALTER TABLE public.client_session OWNER TO postgres;

--
-- Name: client_session_auth_status; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_session_auth_status (
    authenticator character varying(36) NOT NULL,
    status integer,
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_session_auth_status OWNER TO postgres;

--
-- Name: client_session_note; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_session_note (
    name character varying(255) NOT NULL,
    value character varying(255),
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_session_note OWNER TO postgres;

--
-- Name: client_session_prot_mapper; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_session_prot_mapper (
    protocol_mapper_id character varying(36) NOT NULL,
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_session_prot_mapper OWNER TO postgres;

--
-- Name: client_session_role; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_session_role (
    role_id character varying(255) NOT NULL,
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_session_role OWNER TO postgres;

--
-- Name: client_user_session_note; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_user_session_note (
    name character varying(255) NOT NULL,
    value character varying(2048),
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_user_session_note OWNER TO postgres;

--
-- Name: component; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.component (
    id character varying(36) NOT NULL,
    name character varying(255),
    parent_id character varying(36),
    provider_id character varying(36),
    provider_type character varying(255),
    realm_id character varying(36),
    sub_type character varying(255)
);


ALTER TABLE public.component OWNER TO postgres;

--
-- Name: component_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.component_config (
    id character varying(36) NOT NULL,
    component_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(4000)
);


ALTER TABLE public.component_config OWNER TO postgres;

--
-- Name: composite_role; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.composite_role (
    composite character varying(36) NOT NULL,
    child_role character varying(36) NOT NULL
);


ALTER TABLE public.composite_role OWNER TO postgres;

--
-- Name: credential; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.credential (
    id character varying(36) NOT NULL,
    salt bytea,
    type character varying(255),
    user_id character varying(36),
    created_date bigint,
    user_label character varying(255),
    secret_data text,
    credential_data text,
    priority integer
);


ALTER TABLE public.credential OWNER TO postgres;

--
-- Name: databasechangelog; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.databasechangelog (
    id character varying(255) NOT NULL,
    author character varying(255) NOT NULL,
    filename character varying(255) NOT NULL,
    dateexecuted timestamp without time zone NOT NULL,
    orderexecuted integer NOT NULL,
    exectype character varying(10) NOT NULL,
    md5sum character varying(35),
    description character varying(255),
    comments character varying(255),
    tag character varying(255),
    liquibase character varying(20),
    contexts character varying(255),
    labels character varying(255),
    deployment_id character varying(10)
);


ALTER TABLE public.databasechangelog OWNER TO postgres;

--
-- Name: databasechangeloglock; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.databasechangeloglock (
    id integer NOT NULL,
    locked boolean NOT NULL,
    lockgranted timestamp without time zone,
    lockedby character varying(255)
);


ALTER TABLE public.databasechangeloglock OWNER TO postgres;

--
-- Name: default_client_scope; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.default_client_scope (
    realm_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL,
    default_scope boolean DEFAULT false NOT NULL
);


ALTER TABLE public.default_client_scope OWNER TO postgres;

--
-- Name: event_entity; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.event_entity (
    id character varying(36) NOT NULL,
    client_id character varying(255),
    details_json character varying(2550),
    error character varying(255),
    ip_address character varying(255),
    realm_id character varying(255),
    session_id character varying(255),
    event_time bigint,
    type character varying(255),
    user_id character varying(255)
);


ALTER TABLE public.event_entity OWNER TO postgres;

--
-- Name: fed_user_attribute; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fed_user_attribute (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    value character varying(2024)
);


ALTER TABLE public.fed_user_attribute OWNER TO postgres;

--
-- Name: fed_user_consent; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fed_user_consent (
    id character varying(36) NOT NULL,
    client_id character varying(255),
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    created_date bigint,
    last_updated_date bigint,
    client_storage_provider character varying(36),
    external_client_id character varying(255)
);


ALTER TABLE public.fed_user_consent OWNER TO postgres;

--
-- Name: fed_user_consent_cl_scope; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fed_user_consent_cl_scope (
    user_consent_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


ALTER TABLE public.fed_user_consent_cl_scope OWNER TO postgres;

--
-- Name: fed_user_credential; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fed_user_credential (
    id character varying(36) NOT NULL,
    salt bytea,
    type character varying(255),
    created_date bigint,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    user_label character varying(255),
    secret_data text,
    credential_data text,
    priority integer
);


ALTER TABLE public.fed_user_credential OWNER TO postgres;

--
-- Name: fed_user_group_membership; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fed_user_group_membership (
    group_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE public.fed_user_group_membership OWNER TO postgres;

--
-- Name: fed_user_required_action; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fed_user_required_action (
    required_action character varying(255) DEFAULT ' '::character varying NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE public.fed_user_required_action OWNER TO postgres;

--
-- Name: fed_user_role_mapping; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fed_user_role_mapping (
    role_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE public.fed_user_role_mapping OWNER TO postgres;

--
-- Name: federated_identity; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.federated_identity (
    identity_provider character varying(255) NOT NULL,
    realm_id character varying(36),
    federated_user_id character varying(255),
    federated_username character varying(255),
    token text,
    user_id character varying(36) NOT NULL
);


ALTER TABLE public.federated_identity OWNER TO postgres;

--
-- Name: federated_user; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.federated_user (
    id character varying(255) NOT NULL,
    storage_provider_id character varying(255),
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.federated_user OWNER TO postgres;

--
-- Name: group_attribute; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.group_attribute (
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255),
    group_id character varying(36) NOT NULL
);


ALTER TABLE public.group_attribute OWNER TO postgres;

--
-- Name: group_role_mapping; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.group_role_mapping (
    role_id character varying(36) NOT NULL,
    group_id character varying(36) NOT NULL
);


ALTER TABLE public.group_role_mapping OWNER TO postgres;

--
-- Name: identity_provider; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.identity_provider (
    internal_id character varying(36) NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    provider_alias character varying(255),
    provider_id character varying(255),
    store_token boolean DEFAULT false NOT NULL,
    authenticate_by_default boolean DEFAULT false NOT NULL,
    realm_id character varying(36),
    add_token_role boolean DEFAULT true NOT NULL,
    trust_email boolean DEFAULT false NOT NULL,
    first_broker_login_flow_id character varying(36),
    post_broker_login_flow_id character varying(36),
    provider_display_name character varying(255),
    link_only boolean DEFAULT false NOT NULL
);


ALTER TABLE public.identity_provider OWNER TO postgres;

--
-- Name: identity_provider_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.identity_provider_config (
    identity_provider_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.identity_provider_config OWNER TO postgres;

--
-- Name: identity_provider_mapper; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.identity_provider_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    idp_alias character varying(255) NOT NULL,
    idp_mapper_name character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.identity_provider_mapper OWNER TO postgres;

--
-- Name: idp_mapper_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.idp_mapper_config (
    idp_mapper_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.idp_mapper_config OWNER TO postgres;

--
-- Name: keycloak_group; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.keycloak_group (
    id character varying(36) NOT NULL,
    name character varying(255),
    parent_group character varying(36) NOT NULL,
    realm_id character varying(36)
);


ALTER TABLE public.keycloak_group OWNER TO postgres;

--
-- Name: keycloak_role; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.keycloak_role (
    id character varying(36) NOT NULL,
    client_realm_constraint character varying(255),
    client_role boolean DEFAULT false NOT NULL,
    description character varying(255),
    name character varying(255),
    realm_id character varying(255),
    client character varying(36),
    realm character varying(36)
);


ALTER TABLE public.keycloak_role OWNER TO postgres;

--
-- Name: migration_model; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.migration_model (
    id character varying(36) NOT NULL,
    version character varying(36),
    update_time bigint DEFAULT '0'::bigint NOT NULL
);


ALTER TABLE public.migration_model OWNER TO postgres;

--
-- Name: offline_client_session; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.offline_client_session (
    user_session_id character varying(36) NOT NULL,
    client_id character varying(255) NOT NULL,
    offline_flag character varying(4) NOT NULL,
    "timestamp" integer,
    data text,
    client_storage_provider character varying(36) DEFAULT 'local'::character varying NOT NULL,
    external_client_id character varying(255) DEFAULT 'local'::character varying NOT NULL
);


ALTER TABLE public.offline_client_session OWNER TO postgres;

--
-- Name: offline_user_session; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.offline_user_session (
    user_session_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    created_on integer NOT NULL,
    offline_flag character varying(4) NOT NULL,
    data text,
    last_session_refresh integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.offline_user_session OWNER TO postgres;

--
-- Name: policy_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.policy_config (
    policy_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value text
);


ALTER TABLE public.policy_config OWNER TO postgres;

--
-- Name: protocol_mapper; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.protocol_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    protocol character varying(255) NOT NULL,
    protocol_mapper_name character varying(255) NOT NULL,
    client_id character varying(36),
    client_scope_id character varying(36)
);


ALTER TABLE public.protocol_mapper OWNER TO postgres;

--
-- Name: protocol_mapper_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.protocol_mapper_config (
    protocol_mapper_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.protocol_mapper_config OWNER TO postgres;

--
-- Name: realm; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.realm (
    id character varying(36) NOT NULL,
    access_code_lifespan integer,
    user_action_lifespan integer,
    access_token_lifespan integer,
    account_theme character varying(255),
    admin_theme character varying(255),
    email_theme character varying(255),
    enabled boolean DEFAULT false NOT NULL,
    events_enabled boolean DEFAULT false NOT NULL,
    events_expiration bigint,
    login_theme character varying(255),
    name character varying(255),
    not_before integer,
    password_policy character varying(2550),
    registration_allowed boolean DEFAULT false NOT NULL,
    remember_me boolean DEFAULT false NOT NULL,
    reset_password_allowed boolean DEFAULT false NOT NULL,
    social boolean DEFAULT false NOT NULL,
    ssl_required character varying(255),
    sso_idle_timeout integer,
    sso_max_lifespan integer,
    update_profile_on_soc_login boolean DEFAULT false NOT NULL,
    verify_email boolean DEFAULT false NOT NULL,
    master_admin_client character varying(36),
    login_lifespan integer,
    internationalization_enabled boolean DEFAULT false NOT NULL,
    default_locale character varying(255),
    reg_email_as_username boolean DEFAULT false NOT NULL,
    admin_events_enabled boolean DEFAULT false NOT NULL,
    admin_events_details_enabled boolean DEFAULT false NOT NULL,
    edit_username_allowed boolean DEFAULT false NOT NULL,
    otp_policy_counter integer DEFAULT 0,
    otp_policy_window integer DEFAULT 1,
    otp_policy_period integer DEFAULT 30,
    otp_policy_digits integer DEFAULT 6,
    otp_policy_alg character varying(36) DEFAULT 'HmacSHA1'::character varying,
    otp_policy_type character varying(36) DEFAULT 'totp'::character varying,
    browser_flow character varying(36),
    registration_flow character varying(36),
    direct_grant_flow character varying(36),
    reset_credentials_flow character varying(36),
    client_auth_flow character varying(36),
    offline_session_idle_timeout integer DEFAULT 0,
    revoke_refresh_token boolean DEFAULT false NOT NULL,
    access_token_life_implicit integer DEFAULT 0,
    login_with_email_allowed boolean DEFAULT true NOT NULL,
    duplicate_emails_allowed boolean DEFAULT false NOT NULL,
    docker_auth_flow character varying(36),
    refresh_token_max_reuse integer DEFAULT 0,
    allow_user_managed_access boolean DEFAULT false NOT NULL,
    sso_max_lifespan_remember_me integer DEFAULT 0 NOT NULL,
    sso_idle_timeout_remember_me integer DEFAULT 0 NOT NULL,
    default_role character varying(255)
);


ALTER TABLE public.realm OWNER TO postgres;

--
-- Name: realm_attribute; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.realm_attribute (
    name character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    value text
);


ALTER TABLE public.realm_attribute OWNER TO postgres;

--
-- Name: realm_default_groups; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.realm_default_groups (
    realm_id character varying(36) NOT NULL,
    group_id character varying(36) NOT NULL
);


ALTER TABLE public.realm_default_groups OWNER TO postgres;

--
-- Name: realm_enabled_event_types; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.realm_enabled_event_types (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.realm_enabled_event_types OWNER TO postgres;

--
-- Name: realm_events_listeners; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.realm_events_listeners (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.realm_events_listeners OWNER TO postgres;

--
-- Name: realm_localizations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.realm_localizations (
    realm_id character varying(255) NOT NULL,
    locale character varying(255) NOT NULL,
    texts text NOT NULL
);


ALTER TABLE public.realm_localizations OWNER TO postgres;

--
-- Name: realm_required_credential; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.realm_required_credential (
    type character varying(255) NOT NULL,
    form_label character varying(255),
    input boolean DEFAULT false NOT NULL,
    secret boolean DEFAULT false NOT NULL,
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.realm_required_credential OWNER TO postgres;

--
-- Name: realm_smtp_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.realm_smtp_config (
    realm_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE public.realm_smtp_config OWNER TO postgres;

--
-- Name: realm_supported_locales; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.realm_supported_locales (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.realm_supported_locales OWNER TO postgres;

--
-- Name: redirect_uris; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.redirect_uris (
    client_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.redirect_uris OWNER TO postgres;

--
-- Name: required_action_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.required_action_config (
    required_action_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.required_action_config OWNER TO postgres;

--
-- Name: required_action_provider; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.required_action_provider (
    id character varying(36) NOT NULL,
    alias character varying(255),
    name character varying(255),
    realm_id character varying(36),
    enabled boolean DEFAULT false NOT NULL,
    default_action boolean DEFAULT false NOT NULL,
    provider_id character varying(255),
    priority integer
);


ALTER TABLE public.required_action_provider OWNER TO postgres;

--
-- Name: resource_attribute; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.resource_attribute (
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255),
    resource_id character varying(36) NOT NULL
);


ALTER TABLE public.resource_attribute OWNER TO postgres;

--
-- Name: resource_policy; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.resource_policy (
    resource_id character varying(36) NOT NULL,
    policy_id character varying(36) NOT NULL
);


ALTER TABLE public.resource_policy OWNER TO postgres;

--
-- Name: resource_scope; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.resource_scope (
    resource_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


ALTER TABLE public.resource_scope OWNER TO postgres;

--
-- Name: resource_server; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.resource_server (
    id character varying(36) NOT NULL,
    allow_rs_remote_mgmt boolean DEFAULT false NOT NULL,
    policy_enforce_mode character varying(15) NOT NULL,
    decision_strategy smallint DEFAULT '1'::smallint NOT NULL
);


ALTER TABLE public.resource_server OWNER TO postgres;

--
-- Name: resource_server_perm_ticket; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.resource_server_perm_ticket (
    id character varying(36) NOT NULL,
    owner character varying(255) NOT NULL,
    requester character varying(255) NOT NULL,
    created_timestamp bigint NOT NULL,
    granted_timestamp bigint,
    resource_id character varying(36) NOT NULL,
    scope_id character varying(36),
    resource_server_id character varying(36) NOT NULL,
    policy_id character varying(36)
);


ALTER TABLE public.resource_server_perm_ticket OWNER TO postgres;

--
-- Name: resource_server_policy; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.resource_server_policy (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    description character varying(255),
    type character varying(255) NOT NULL,
    decision_strategy character varying(20),
    logic character varying(20),
    resource_server_id character varying(36) NOT NULL,
    owner character varying(255)
);


ALTER TABLE public.resource_server_policy OWNER TO postgres;

--
-- Name: resource_server_resource; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.resource_server_resource (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    type character varying(255),
    icon_uri character varying(255),
    owner character varying(255) NOT NULL,
    resource_server_id character varying(36) NOT NULL,
    owner_managed_access boolean DEFAULT false NOT NULL,
    display_name character varying(255)
);


ALTER TABLE public.resource_server_resource OWNER TO postgres;

--
-- Name: resource_server_scope; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.resource_server_scope (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    icon_uri character varying(255),
    resource_server_id character varying(36) NOT NULL,
    display_name character varying(255)
);


ALTER TABLE public.resource_server_scope OWNER TO postgres;

--
-- Name: resource_uris; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.resource_uris (
    resource_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.resource_uris OWNER TO postgres;

--
-- Name: role_attribute; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.role_attribute (
    id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255)
);


ALTER TABLE public.role_attribute OWNER TO postgres;

--
-- Name: scope_mapping; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.scope_mapping (
    client_id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL
);


ALTER TABLE public.scope_mapping OWNER TO postgres;

--
-- Name: scope_policy; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.scope_policy (
    scope_id character varying(36) NOT NULL,
    policy_id character varying(36) NOT NULL
);


ALTER TABLE public.scope_policy OWNER TO postgres;

--
-- Name: user_attribute; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_attribute (
    name character varying(255) NOT NULL,
    value character varying(255),
    user_id character varying(36) NOT NULL,
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL
);


ALTER TABLE public.user_attribute OWNER TO postgres;

--
-- Name: user_consent; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_consent (
    id character varying(36) NOT NULL,
    client_id character varying(255),
    user_id character varying(36) NOT NULL,
    created_date bigint,
    last_updated_date bigint,
    client_storage_provider character varying(36),
    external_client_id character varying(255)
);


ALTER TABLE public.user_consent OWNER TO postgres;

--
-- Name: user_consent_client_scope; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_consent_client_scope (
    user_consent_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


ALTER TABLE public.user_consent_client_scope OWNER TO postgres;

--
-- Name: user_entity; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_entity (
    id character varying(36) NOT NULL,
    email character varying(255),
    email_constraint character varying(255),
    email_verified boolean DEFAULT false NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    federation_link character varying(255),
    first_name character varying(255),
    last_name character varying(255),
    realm_id character varying(255),
    username character varying(255),
    created_timestamp bigint,
    service_account_client_link character varying(255),
    not_before integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.user_entity OWNER TO postgres;

--
-- Name: user_federation_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_federation_config (
    user_federation_provider_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE public.user_federation_config OWNER TO postgres;

--
-- Name: user_federation_mapper; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_federation_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    federation_provider_id character varying(36) NOT NULL,
    federation_mapper_type character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.user_federation_mapper OWNER TO postgres;

--
-- Name: user_federation_mapper_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_federation_mapper_config (
    user_federation_mapper_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE public.user_federation_mapper_config OWNER TO postgres;

--
-- Name: user_federation_provider; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_federation_provider (
    id character varying(36) NOT NULL,
    changed_sync_period integer,
    display_name character varying(255),
    full_sync_period integer,
    last_sync integer,
    priority integer,
    provider_name character varying(255),
    realm_id character varying(36)
);


ALTER TABLE public.user_federation_provider OWNER TO postgres;

--
-- Name: user_group_membership; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_group_membership (
    group_id character varying(36) NOT NULL,
    user_id character varying(36) NOT NULL
);


ALTER TABLE public.user_group_membership OWNER TO postgres;

--
-- Name: user_required_action; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_required_action (
    user_id character varying(36) NOT NULL,
    required_action character varying(255) DEFAULT ' '::character varying NOT NULL
);


ALTER TABLE public.user_required_action OWNER TO postgres;

--
-- Name: user_role_mapping; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_role_mapping (
    role_id character varying(255) NOT NULL,
    user_id character varying(36) NOT NULL
);


ALTER TABLE public.user_role_mapping OWNER TO postgres;

--
-- Name: user_session; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_session (
    id character varying(36) NOT NULL,
    auth_method character varying(255),
    ip_address character varying(255),
    last_session_refresh integer,
    login_username character varying(255),
    realm_id character varying(255),
    remember_me boolean DEFAULT false NOT NULL,
    started integer,
    user_id character varying(255),
    user_session_state integer,
    broker_session_id character varying(255),
    broker_user_id character varying(255)
);


ALTER TABLE public.user_session OWNER TO postgres;

--
-- Name: user_session_note; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_session_note (
    user_session character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(2048)
);


ALTER TABLE public.user_session_note OWNER TO postgres;

--
-- Name: username_login_failure; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.username_login_failure (
    realm_id character varying(36) NOT NULL,
    username character varying(255) NOT NULL,
    failed_login_not_before integer,
    last_failure bigint,
    last_ip_failure character varying(255),
    num_failures integer
);


ALTER TABLE public.username_login_failure OWNER TO postgres;

--
-- Name: web_origins; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.web_origins (
    client_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.web_origins OWNER TO postgres;

--
-- Data for Name: admin_event_entity; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.admin_event_entity (id, admin_event_time, realm_id, operation_type, auth_realm_id, auth_client_id, auth_user_id, ip_address, resource_path, representation, error, resource_type) FROM stdin;
\.


--
-- Data for Name: associated_policy; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.associated_policy (policy_id, associated_policy_id) FROM stdin;
\.


--
-- Data for Name: authentication_execution; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) FROM stdin;
dc189261-e5df-4a84-94ef-74899d9b5032	\N	auth-cookie	d86ec37e-5c02-4219-bb0d-99cb545457ff	53d7b7d6-2888-4ee8-8819-2f54318a7cf3	2	10	f	\N	\N
699e2554-831e-43fc-8be0-c4264447f3f4	\N	auth-spnego	d86ec37e-5c02-4219-bb0d-99cb545457ff	53d7b7d6-2888-4ee8-8819-2f54318a7cf3	3	20	f	\N	\N
6327da77-067b-41eb-9d91-4085efc36353	\N	identity-provider-redirector	d86ec37e-5c02-4219-bb0d-99cb545457ff	53d7b7d6-2888-4ee8-8819-2f54318a7cf3	2	25	f	\N	\N
4d280323-c644-439f-8445-71f5995060a1	\N	\N	d86ec37e-5c02-4219-bb0d-99cb545457ff	53d7b7d6-2888-4ee8-8819-2f54318a7cf3	2	30	t	f943bb7c-d61f-4a40-a40c-54d5d9231609	\N
425214c2-7fa8-43a8-ac06-2b613d3f8eed	\N	auth-username-password-form	d86ec37e-5c02-4219-bb0d-99cb545457ff	f943bb7c-d61f-4a40-a40c-54d5d9231609	0	10	f	\N	\N
1783ec95-467e-4bfc-adbf-6d24079dca13	\N	\N	d86ec37e-5c02-4219-bb0d-99cb545457ff	f943bb7c-d61f-4a40-a40c-54d5d9231609	1	20	t	cbd5fe62-d24f-492a-91f3-f4481d5c156a	\N
e85f7693-98a0-45d5-b615-eea8cfd42425	\N	conditional-user-configured	d86ec37e-5c02-4219-bb0d-99cb545457ff	cbd5fe62-d24f-492a-91f3-f4481d5c156a	0	10	f	\N	\N
d4f48530-a3a1-4d11-b257-c92d6dbb60fe	\N	auth-otp-form	d86ec37e-5c02-4219-bb0d-99cb545457ff	cbd5fe62-d24f-492a-91f3-f4481d5c156a	0	20	f	\N	\N
6e806d88-eb03-47b7-b376-d756654809b5	\N	direct-grant-validate-username	d86ec37e-5c02-4219-bb0d-99cb545457ff	e8462dba-6e4f-4785-8ffb-002f86b7c0f5	0	10	f	\N	\N
2d301e47-9055-4b60-b28c-d71294bc0ab0	\N	direct-grant-validate-password	d86ec37e-5c02-4219-bb0d-99cb545457ff	e8462dba-6e4f-4785-8ffb-002f86b7c0f5	0	20	f	\N	\N
02771a43-094e-416e-a624-a947d48b72a5	\N	\N	d86ec37e-5c02-4219-bb0d-99cb545457ff	e8462dba-6e4f-4785-8ffb-002f86b7c0f5	1	30	t	5679932e-a4b3-4634-af18-96e478024483	\N
8eea88df-8460-4884-ac21-095980842947	\N	conditional-user-configured	d86ec37e-5c02-4219-bb0d-99cb545457ff	5679932e-a4b3-4634-af18-96e478024483	0	10	f	\N	\N
3f097417-154f-4b19-ae5b-7aa6ebb206de	\N	direct-grant-validate-otp	d86ec37e-5c02-4219-bb0d-99cb545457ff	5679932e-a4b3-4634-af18-96e478024483	0	20	f	\N	\N
d6cd7687-cbdb-47e6-84b0-12788244b081	\N	registration-page-form	d86ec37e-5c02-4219-bb0d-99cb545457ff	e624c028-7185-4249-921c-fc1ab3a68189	0	10	t	6b227bef-7c19-4956-9c10-e756c968d2d0	\N
843938b7-dfb0-4210-a5f8-eff2210ef324	\N	registration-user-creation	d86ec37e-5c02-4219-bb0d-99cb545457ff	6b227bef-7c19-4956-9c10-e756c968d2d0	0	20	f	\N	\N
928464ee-469c-47fa-84ba-cfd0c48fa58a	\N	registration-profile-action	d86ec37e-5c02-4219-bb0d-99cb545457ff	6b227bef-7c19-4956-9c10-e756c968d2d0	0	40	f	\N	\N
04fbc837-7edb-4171-a42e-41f207d468dd	\N	registration-password-action	d86ec37e-5c02-4219-bb0d-99cb545457ff	6b227bef-7c19-4956-9c10-e756c968d2d0	0	50	f	\N	\N
b860ab68-1b72-4fb9-8e29-84e078cc3886	\N	registration-recaptcha-action	d86ec37e-5c02-4219-bb0d-99cb545457ff	6b227bef-7c19-4956-9c10-e756c968d2d0	3	60	f	\N	\N
b8fdc02b-a2eb-44e3-a74a-2ce514cee1ff	\N	reset-credentials-choose-user	d86ec37e-5c02-4219-bb0d-99cb545457ff	fbd4f9f6-c609-49ff-951e-07907ac1cec2	0	10	f	\N	\N
aa1cda07-20bc-4eae-aadc-55a82161a15e	\N	reset-credential-email	d86ec37e-5c02-4219-bb0d-99cb545457ff	fbd4f9f6-c609-49ff-951e-07907ac1cec2	0	20	f	\N	\N
09069698-215d-4e4e-a3e2-fdb5515c3dc5	\N	reset-password	d86ec37e-5c02-4219-bb0d-99cb545457ff	fbd4f9f6-c609-49ff-951e-07907ac1cec2	0	30	f	\N	\N
c7e350e7-777c-4c60-af58-7301aa97a9ab	\N	\N	d86ec37e-5c02-4219-bb0d-99cb545457ff	fbd4f9f6-c609-49ff-951e-07907ac1cec2	1	40	t	2ec7fad9-0bd7-4e34-9e19-bbeb19291b19	\N
42c3592f-7030-49cf-a2bb-1a820cff8d6c	\N	conditional-user-configured	d86ec37e-5c02-4219-bb0d-99cb545457ff	2ec7fad9-0bd7-4e34-9e19-bbeb19291b19	0	10	f	\N	\N
4146093a-c158-47bc-9b7f-63c074c622ab	\N	reset-otp	d86ec37e-5c02-4219-bb0d-99cb545457ff	2ec7fad9-0bd7-4e34-9e19-bbeb19291b19	0	20	f	\N	\N
7559f018-23c5-4db9-81bf-d0f1b225ddff	\N	client-secret	d86ec37e-5c02-4219-bb0d-99cb545457ff	5fd90bc0-23c2-4127-b579-45d454887eee	2	10	f	\N	\N
e6c4fcee-5527-4d79-b6bc-df3d0f646481	\N	client-jwt	d86ec37e-5c02-4219-bb0d-99cb545457ff	5fd90bc0-23c2-4127-b579-45d454887eee	2	20	f	\N	\N
5eefc179-f0f7-44ba-a27f-b91214bfd0ea	\N	client-secret-jwt	d86ec37e-5c02-4219-bb0d-99cb545457ff	5fd90bc0-23c2-4127-b579-45d454887eee	2	30	f	\N	\N
a152ea82-7938-4ea6-82dc-4a521b5cdc09	\N	client-x509	d86ec37e-5c02-4219-bb0d-99cb545457ff	5fd90bc0-23c2-4127-b579-45d454887eee	2	40	f	\N	\N
7eefb258-0b24-4c07-9abb-54b2051880ae	\N	idp-review-profile	d86ec37e-5c02-4219-bb0d-99cb545457ff	41d7a543-796a-4c08-835f-e65aac31c8d4	0	10	f	\N	63b63a8b-7aba-4408-a479-9fd64e59a548
a78aa79a-83af-43cf-93fa-c85063820bd3	\N	\N	d86ec37e-5c02-4219-bb0d-99cb545457ff	41d7a543-796a-4c08-835f-e65aac31c8d4	0	20	t	3c2c46cf-28de-4910-aa17-ba11b69b91c0	\N
ac0e50fb-d6fa-4db1-911f-5d7e79098075	\N	idp-create-user-if-unique	d86ec37e-5c02-4219-bb0d-99cb545457ff	3c2c46cf-28de-4910-aa17-ba11b69b91c0	2	10	f	\N	7d6d0243-e2c8-420e-9672-d4b96e16c2cd
56344f95-d3c1-412c-9865-5154853224ac	\N	\N	d86ec37e-5c02-4219-bb0d-99cb545457ff	3c2c46cf-28de-4910-aa17-ba11b69b91c0	2	20	t	ed1d3543-b910-4279-809a-dffd2a787b06	\N
1781dee6-f03d-4ef7-9f36-5924135711ee	\N	idp-confirm-link	d86ec37e-5c02-4219-bb0d-99cb545457ff	ed1d3543-b910-4279-809a-dffd2a787b06	0	10	f	\N	\N
5ee738c3-11d2-47f3-9d90-1dc8968801c0	\N	\N	d86ec37e-5c02-4219-bb0d-99cb545457ff	ed1d3543-b910-4279-809a-dffd2a787b06	0	20	t	d9c16265-c901-4a3f-9c48-dc11dd909e06	\N
7380c9e1-2a65-4ead-9366-4b905602be7c	\N	idp-email-verification	d86ec37e-5c02-4219-bb0d-99cb545457ff	d9c16265-c901-4a3f-9c48-dc11dd909e06	2	10	f	\N	\N
6153448e-0ec6-4082-934c-683d96a6c208	\N	\N	d86ec37e-5c02-4219-bb0d-99cb545457ff	d9c16265-c901-4a3f-9c48-dc11dd909e06	2	20	t	3f4df87a-aa97-43f2-a9c0-d472dd3dd636	\N
5fddc80b-8277-4b50-9e9c-49b5feac40b0	\N	idp-username-password-form	d86ec37e-5c02-4219-bb0d-99cb545457ff	3f4df87a-aa97-43f2-a9c0-d472dd3dd636	0	10	f	\N	\N
d76f065f-91c2-42cb-aa6e-af55a4607889	\N	\N	d86ec37e-5c02-4219-bb0d-99cb545457ff	3f4df87a-aa97-43f2-a9c0-d472dd3dd636	1	20	t	bc843710-aa2b-49ce-96e4-9f3980388d03	\N
b8189e03-64ea-41f2-a329-d441211a7a9a	\N	conditional-user-configured	d86ec37e-5c02-4219-bb0d-99cb545457ff	bc843710-aa2b-49ce-96e4-9f3980388d03	0	10	f	\N	\N
c361328a-06cd-488e-b206-76be89265f98	\N	auth-otp-form	d86ec37e-5c02-4219-bb0d-99cb545457ff	bc843710-aa2b-49ce-96e4-9f3980388d03	0	20	f	\N	\N
b5c98507-451b-4a60-8a53-8336fe849cdd	\N	http-basic-authenticator	d86ec37e-5c02-4219-bb0d-99cb545457ff	859987de-376c-4b47-bae9-022a8fbac7fe	0	10	f	\N	\N
e561040c-8c69-49e7-b327-3aa8e15a3758	\N	docker-http-basic-authenticator	d86ec37e-5c02-4219-bb0d-99cb545457ff	0d92b695-e6a8-4438-8cb9-f1def22bded4	0	10	f	\N	\N
8e7d8b88-b51b-4b71-8221-ef9f7750e1c2	\N	no-cookie-redirect	d86ec37e-5c02-4219-bb0d-99cb545457ff	c15e3b06-7da4-411a-b1c2-091913c7a15f	0	10	f	\N	\N
d140d7de-7f0e-47fb-996d-8d2b337dcbf1	\N	\N	d86ec37e-5c02-4219-bb0d-99cb545457ff	c15e3b06-7da4-411a-b1c2-091913c7a15f	0	20	t	41183b59-92d4-4af9-908c-8591c85f89a9	\N
94a72944-100e-4674-9d5f-8c4a1138f6c3	\N	basic-auth	d86ec37e-5c02-4219-bb0d-99cb545457ff	41183b59-92d4-4af9-908c-8591c85f89a9	0	10	f	\N	\N
2659410a-1445-4105-94dc-3a645f6f9199	\N	basic-auth-otp	d86ec37e-5c02-4219-bb0d-99cb545457ff	41183b59-92d4-4af9-908c-8591c85f89a9	3	20	f	\N	\N
a4087935-9d99-4c15-8bd4-c2e748887761	\N	auth-spnego	d86ec37e-5c02-4219-bb0d-99cb545457ff	41183b59-92d4-4af9-908c-8591c85f89a9	3	30	f	\N	\N
1a234f7a-26bb-451a-b22a-2ab0fa0c20eb	\N	auth-cookie	ba1a6f7d-badd-4ac5-9ce3-3a5dc0dd1d0b	e3c72776-738f-4a50-8b65-15737aeb31cd	2	10	f	\N	\N
e132be50-20d0-4aad-b4a4-0bb1a03f09cc	\N	auth-spnego	ba1a6f7d-badd-4ac5-9ce3-3a5dc0dd1d0b	e3c72776-738f-4a50-8b65-15737aeb31cd	3	20	f	\N	\N
942bf8ac-0a52-4318-90ea-b3d850dfd34d	\N	identity-provider-redirector	ba1a6f7d-badd-4ac5-9ce3-3a5dc0dd1d0b	e3c72776-738f-4a50-8b65-15737aeb31cd	2	25	f	\N	\N
9275c327-f81d-4a70-8510-828741f6e631	\N	\N	ba1a6f7d-badd-4ac5-9ce3-3a5dc0dd1d0b	e3c72776-738f-4a50-8b65-15737aeb31cd	2	30	t	794794be-b13d-4e04-97ac-bbd1301f29c4	\N
12875477-a8b0-42c4-9522-1ce3c7114e18	\N	auth-username-password-form	ba1a6f7d-badd-4ac5-9ce3-3a5dc0dd1d0b	794794be-b13d-4e04-97ac-bbd1301f29c4	0	10	f	\N	\N
eb93ac15-145b-4d0f-adc6-17fa1694bbdf	\N	\N	ba1a6f7d-badd-4ac5-9ce3-3a5dc0dd1d0b	794794be-b13d-4e04-97ac-bbd1301f29c4	1	20	t	39cc4f95-831f-4252-be95-f7d9b980bc4a	\N
042da584-5f8d-4c9b-b20c-27c583d563ce	\N	conditional-user-configured	ba1a6f7d-badd-4ac5-9ce3-3a5dc0dd1d0b	39cc4f95-831f-4252-be95-f7d9b980bc4a	0	10	f	\N	\N
933238f5-d11f-4cac-95c6-713f0454d8c4	\N	auth-otp-form	ba1a6f7d-badd-4ac5-9ce3-3a5dc0dd1d0b	39cc4f95-831f-4252-be95-f7d9b980bc4a	0	20	f	\N	\N
6d80b9d8-1897-41db-ad4e-5c13b1af4bb0	\N	direct-grant-validate-username	ba1a6f7d-badd-4ac5-9ce3-3a5dc0dd1d0b	00f7b56a-1e4b-445a-a424-b7706190f506	0	10	f	\N	\N
fecd9245-0b46-4ffc-9d8a-465374c174b8	\N	direct-grant-validate-password	ba1a6f7d-badd-4ac5-9ce3-3a5dc0dd1d0b	00f7b56a-1e4b-445a-a424-b7706190f506	0	20	f	\N	\N
29dc79dc-9eac-4408-be4a-5d2ed831e1dc	\N	\N	ba1a6f7d-badd-4ac5-9ce3-3a5dc0dd1d0b	00f7b56a-1e4b-445a-a424-b7706190f506	1	30	t	dc95a3ce-05e5-4114-8c36-56448114f08e	\N
13922d1a-f28b-4670-8420-f5eb3ab43977	\N	conditional-user-configured	ba1a6f7d-badd-4ac5-9ce3-3a5dc0dd1d0b	dc95a3ce-05e5-4114-8c36-56448114f08e	0	10	f	\N	\N
cc350582-9e0d-4b6c-ad6f-dde71d6b256c	\N	direct-grant-validate-otp	ba1a6f7d-badd-4ac5-9ce3-3a5dc0dd1d0b	dc95a3ce-05e5-4114-8c36-56448114f08e	0	20	f	\N	\N
e4fd3a74-bc8f-4783-bd0e-4322c1914638	\N	registration-page-form	ba1a6f7d-badd-4ac5-9ce3-3a5dc0dd1d0b	8b44a050-5ec9-4e52-b6a3-89fd59bdeb91	0	10	t	b875f9b6-64f9-4864-a98b-c80b14070d1b	\N
8a2160a4-29b2-4893-97dd-ef3b00d2421b	\N	registration-user-creation	ba1a6f7d-badd-4ac5-9ce3-3a5dc0dd1d0b	b875f9b6-64f9-4864-a98b-c80b14070d1b	0	20	f	\N	\N
bd6741f2-aa6f-4e85-bf50-bd80c2805a82	\N	registration-profile-action	ba1a6f7d-badd-4ac5-9ce3-3a5dc0dd1d0b	b875f9b6-64f9-4864-a98b-c80b14070d1b	0	40	f	\N	\N
09669f0d-859c-4087-a92d-2aad22838ba8	\N	registration-password-action	ba1a6f7d-badd-4ac5-9ce3-3a5dc0dd1d0b	b875f9b6-64f9-4864-a98b-c80b14070d1b	0	50	f	\N	\N
856f274a-ff54-4ea0-8dde-934ba5ee4a7c	\N	registration-recaptcha-action	ba1a6f7d-badd-4ac5-9ce3-3a5dc0dd1d0b	b875f9b6-64f9-4864-a98b-c80b14070d1b	3	60	f	\N	\N
a2d41f0a-ee1e-4211-966e-f1d125b3e932	\N	reset-credentials-choose-user	ba1a6f7d-badd-4ac5-9ce3-3a5dc0dd1d0b	fcb6b793-200e-492a-a09b-f3ea026f3a6a	0	10	f	\N	\N
b9f61786-33c4-4c38-be5d-abf794585df1	\N	reset-credential-email	ba1a6f7d-badd-4ac5-9ce3-3a5dc0dd1d0b	fcb6b793-200e-492a-a09b-f3ea026f3a6a	0	20	f	\N	\N
c33dfbe9-d6de-4717-9a1d-7395c1aadec9	\N	reset-password	ba1a6f7d-badd-4ac5-9ce3-3a5dc0dd1d0b	fcb6b793-200e-492a-a09b-f3ea026f3a6a	0	30	f	\N	\N
bb55d58f-9870-491e-bf18-ab18157b78a6	\N	\N	ba1a6f7d-badd-4ac5-9ce3-3a5dc0dd1d0b	fcb6b793-200e-492a-a09b-f3ea026f3a6a	1	40	t	219b5cae-1ac4-4710-bce0-e71c96c9a27f	\N
9610920b-141d-480a-a82b-7d42a268ff3f	\N	conditional-user-configured	ba1a6f7d-badd-4ac5-9ce3-3a5dc0dd1d0b	219b5cae-1ac4-4710-bce0-e71c96c9a27f	0	10	f	\N	\N
1824fe8b-3834-4049-8a3e-3da3d195f9c9	\N	reset-otp	ba1a6f7d-badd-4ac5-9ce3-3a5dc0dd1d0b	219b5cae-1ac4-4710-bce0-e71c96c9a27f	0	20	f	\N	\N
54a07c2c-32a4-4f77-af23-904bc651917d	\N	client-secret	ba1a6f7d-badd-4ac5-9ce3-3a5dc0dd1d0b	903d0900-b5b6-4055-8075-957d04292a1b	2	10	f	\N	\N
f1e36684-8b4d-4cf0-a7be-689753b27eaa	\N	client-jwt	ba1a6f7d-badd-4ac5-9ce3-3a5dc0dd1d0b	903d0900-b5b6-4055-8075-957d04292a1b	2	20	f	\N	\N
a707ecdd-ae5b-439f-b078-5ed69a4142d7	\N	client-secret-jwt	ba1a6f7d-badd-4ac5-9ce3-3a5dc0dd1d0b	903d0900-b5b6-4055-8075-957d04292a1b	2	30	f	\N	\N
2142c1c5-adc3-483c-af3c-1a92c8906289	\N	client-x509	ba1a6f7d-badd-4ac5-9ce3-3a5dc0dd1d0b	903d0900-b5b6-4055-8075-957d04292a1b	2	40	f	\N	\N
341f7211-b65e-4eb0-8596-082c415955d1	\N	idp-review-profile	ba1a6f7d-badd-4ac5-9ce3-3a5dc0dd1d0b	15dd702f-e336-4365-9158-2b372262564c	0	10	f	\N	6eb438e3-bab6-4f50-a96d-71842e021e24
f9bc9160-cf93-49ae-9fad-4d384d52b912	\N	\N	ba1a6f7d-badd-4ac5-9ce3-3a5dc0dd1d0b	15dd702f-e336-4365-9158-2b372262564c	0	20	t	d37ee4f2-3e4f-44a5-901f-9a336a0a45a7	\N
576f0f93-2dd8-44a7-8bdb-3638c9b46797	\N	idp-create-user-if-unique	ba1a6f7d-badd-4ac5-9ce3-3a5dc0dd1d0b	d37ee4f2-3e4f-44a5-901f-9a336a0a45a7	2	10	f	\N	eab61f48-a114-4024-a79e-a73aa0428019
6879e930-af8d-4de1-a34d-487076264538	\N	\N	ba1a6f7d-badd-4ac5-9ce3-3a5dc0dd1d0b	d37ee4f2-3e4f-44a5-901f-9a336a0a45a7	2	20	t	4013ec87-0ff1-43dc-a227-b3bb40c8832c	\N
6fb5aad6-c867-4180-8827-d81b1172100f	\N	idp-confirm-link	ba1a6f7d-badd-4ac5-9ce3-3a5dc0dd1d0b	4013ec87-0ff1-43dc-a227-b3bb40c8832c	0	10	f	\N	\N
0b985687-198c-48d4-9f23-b6370efec11e	\N	\N	ba1a6f7d-badd-4ac5-9ce3-3a5dc0dd1d0b	4013ec87-0ff1-43dc-a227-b3bb40c8832c	0	20	t	ca90292d-53d5-492a-a230-e5c72767f75e	\N
51ed767f-02a5-47a3-8c90-e3be84c34564	\N	idp-email-verification	ba1a6f7d-badd-4ac5-9ce3-3a5dc0dd1d0b	ca90292d-53d5-492a-a230-e5c72767f75e	2	10	f	\N	\N
09aff16e-1c02-43bc-8ae3-fa41229216e3	\N	\N	ba1a6f7d-badd-4ac5-9ce3-3a5dc0dd1d0b	ca90292d-53d5-492a-a230-e5c72767f75e	2	20	t	f50c497c-bb30-49ef-859d-de81654535f9	\N
a53441ab-ffc3-41c6-848b-4680d816a62c	\N	idp-username-password-form	ba1a6f7d-badd-4ac5-9ce3-3a5dc0dd1d0b	f50c497c-bb30-49ef-859d-de81654535f9	0	10	f	\N	\N
84a5bc71-e5ea-4b46-a44d-5f723d771088	\N	\N	ba1a6f7d-badd-4ac5-9ce3-3a5dc0dd1d0b	f50c497c-bb30-49ef-859d-de81654535f9	1	20	t	bcc0a2fa-490f-4da0-b4c9-a65eec3a104c	\N
cbba2c46-cba8-49f1-ae75-06bf96cbd344	\N	conditional-user-configured	ba1a6f7d-badd-4ac5-9ce3-3a5dc0dd1d0b	bcc0a2fa-490f-4da0-b4c9-a65eec3a104c	0	10	f	\N	\N
5a47f588-6fd4-4444-9b39-2f29137394e5	\N	auth-otp-form	ba1a6f7d-badd-4ac5-9ce3-3a5dc0dd1d0b	bcc0a2fa-490f-4da0-b4c9-a65eec3a104c	0	20	f	\N	\N
2245167e-2ac1-4422-9089-2015e2efb516	\N	http-basic-authenticator	ba1a6f7d-badd-4ac5-9ce3-3a5dc0dd1d0b	bef25de2-6c10-4209-b35f-a79c71db0155	0	10	f	\N	\N
96296d68-486e-4347-9706-0574a4abbbdb	\N	docker-http-basic-authenticator	ba1a6f7d-badd-4ac5-9ce3-3a5dc0dd1d0b	e3935ad1-5899-48a5-be90-c4956388f55e	0	10	f	\N	\N
e89b1258-3f06-4804-b4a3-9bb65cff35f9	\N	no-cookie-redirect	ba1a6f7d-badd-4ac5-9ce3-3a5dc0dd1d0b	56539a41-0362-4c27-abc7-8b3005d5b501	0	10	f	\N	\N
89eaa52a-9d64-495e-8c18-536d1dd7059d	\N	\N	ba1a6f7d-badd-4ac5-9ce3-3a5dc0dd1d0b	56539a41-0362-4c27-abc7-8b3005d5b501	0	20	t	de921f34-6628-46cf-96cf-9c536e9657aa	\N
3d1c7e1b-7678-4c5f-8b5a-d404ad26b6e4	\N	basic-auth	ba1a6f7d-badd-4ac5-9ce3-3a5dc0dd1d0b	de921f34-6628-46cf-96cf-9c536e9657aa	0	10	f	\N	\N
6832701d-ef25-423f-9e52-dfc1e7af176d	\N	basic-auth-otp	ba1a6f7d-badd-4ac5-9ce3-3a5dc0dd1d0b	de921f34-6628-46cf-96cf-9c536e9657aa	3	20	f	\N	\N
ec93f25c-a750-4956-a279-d24ae996446a	\N	auth-spnego	ba1a6f7d-badd-4ac5-9ce3-3a5dc0dd1d0b	de921f34-6628-46cf-96cf-9c536e9657aa	3	30	f	\N	\N
\.


--
-- Data for Name: authentication_flow; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) FROM stdin;
53d7b7d6-2888-4ee8-8819-2f54318a7cf3	browser	browser based authentication	d86ec37e-5c02-4219-bb0d-99cb545457ff	basic-flow	t	t
f943bb7c-d61f-4a40-a40c-54d5d9231609	forms	Username, password, otp and other auth forms.	d86ec37e-5c02-4219-bb0d-99cb545457ff	basic-flow	f	t
cbd5fe62-d24f-492a-91f3-f4481d5c156a	Browser - Conditional OTP	Flow to determine if the OTP is required for the authentication	d86ec37e-5c02-4219-bb0d-99cb545457ff	basic-flow	f	t
e8462dba-6e4f-4785-8ffb-002f86b7c0f5	direct grant	OpenID Connect Resource Owner Grant	d86ec37e-5c02-4219-bb0d-99cb545457ff	basic-flow	t	t
5679932e-a4b3-4634-af18-96e478024483	Direct Grant - Conditional OTP	Flow to determine if the OTP is required for the authentication	d86ec37e-5c02-4219-bb0d-99cb545457ff	basic-flow	f	t
e624c028-7185-4249-921c-fc1ab3a68189	registration	registration flow	d86ec37e-5c02-4219-bb0d-99cb545457ff	basic-flow	t	t
6b227bef-7c19-4956-9c10-e756c968d2d0	registration form	registration form	d86ec37e-5c02-4219-bb0d-99cb545457ff	form-flow	f	t
fbd4f9f6-c609-49ff-951e-07907ac1cec2	reset credentials	Reset credentials for a user if they forgot their password or something	d86ec37e-5c02-4219-bb0d-99cb545457ff	basic-flow	t	t
2ec7fad9-0bd7-4e34-9e19-bbeb19291b19	Reset - Conditional OTP	Flow to determine if the OTP should be reset or not. Set to REQUIRED to force.	d86ec37e-5c02-4219-bb0d-99cb545457ff	basic-flow	f	t
5fd90bc0-23c2-4127-b579-45d454887eee	clients	Base authentication for clients	d86ec37e-5c02-4219-bb0d-99cb545457ff	client-flow	t	t
41d7a543-796a-4c08-835f-e65aac31c8d4	first broker login	Actions taken after first broker login with identity provider account, which is not yet linked to any Keycloak account	d86ec37e-5c02-4219-bb0d-99cb545457ff	basic-flow	t	t
3c2c46cf-28de-4910-aa17-ba11b69b91c0	User creation or linking	Flow for the existing/non-existing user alternatives	d86ec37e-5c02-4219-bb0d-99cb545457ff	basic-flow	f	t
ed1d3543-b910-4279-809a-dffd2a787b06	Handle Existing Account	Handle what to do if there is existing account with same email/username like authenticated identity provider	d86ec37e-5c02-4219-bb0d-99cb545457ff	basic-flow	f	t
d9c16265-c901-4a3f-9c48-dc11dd909e06	Account verification options	Method with which to verity the existing account	d86ec37e-5c02-4219-bb0d-99cb545457ff	basic-flow	f	t
3f4df87a-aa97-43f2-a9c0-d472dd3dd636	Verify Existing Account by Re-authentication	Reauthentication of existing account	d86ec37e-5c02-4219-bb0d-99cb545457ff	basic-flow	f	t
bc843710-aa2b-49ce-96e4-9f3980388d03	First broker login - Conditional OTP	Flow to determine if the OTP is required for the authentication	d86ec37e-5c02-4219-bb0d-99cb545457ff	basic-flow	f	t
859987de-376c-4b47-bae9-022a8fbac7fe	saml ecp	SAML ECP Profile Authentication Flow	d86ec37e-5c02-4219-bb0d-99cb545457ff	basic-flow	t	t
0d92b695-e6a8-4438-8cb9-f1def22bded4	docker auth	Used by Docker clients to authenticate against the IDP	d86ec37e-5c02-4219-bb0d-99cb545457ff	basic-flow	t	t
c15e3b06-7da4-411a-b1c2-091913c7a15f	http challenge	An authentication flow based on challenge-response HTTP Authentication Schemes	d86ec37e-5c02-4219-bb0d-99cb545457ff	basic-flow	t	t
41183b59-92d4-4af9-908c-8591c85f89a9	Authentication Options	Authentication options.	d86ec37e-5c02-4219-bb0d-99cb545457ff	basic-flow	f	t
e3c72776-738f-4a50-8b65-15737aeb31cd	browser	browser based authentication	ba1a6f7d-badd-4ac5-9ce3-3a5dc0dd1d0b	basic-flow	t	t
794794be-b13d-4e04-97ac-bbd1301f29c4	forms	Username, password, otp and other auth forms.	ba1a6f7d-badd-4ac5-9ce3-3a5dc0dd1d0b	basic-flow	f	t
39cc4f95-831f-4252-be95-f7d9b980bc4a	Browser - Conditional OTP	Flow to determine if the OTP is required for the authentication	ba1a6f7d-badd-4ac5-9ce3-3a5dc0dd1d0b	basic-flow	f	t
00f7b56a-1e4b-445a-a424-b7706190f506	direct grant	OpenID Connect Resource Owner Grant	ba1a6f7d-badd-4ac5-9ce3-3a5dc0dd1d0b	basic-flow	t	t
dc95a3ce-05e5-4114-8c36-56448114f08e	Direct Grant - Conditional OTP	Flow to determine if the OTP is required for the authentication	ba1a6f7d-badd-4ac5-9ce3-3a5dc0dd1d0b	basic-flow	f	t
8b44a050-5ec9-4e52-b6a3-89fd59bdeb91	registration	registration flow	ba1a6f7d-badd-4ac5-9ce3-3a5dc0dd1d0b	basic-flow	t	t
b875f9b6-64f9-4864-a98b-c80b14070d1b	registration form	registration form	ba1a6f7d-badd-4ac5-9ce3-3a5dc0dd1d0b	form-flow	f	t
fcb6b793-200e-492a-a09b-f3ea026f3a6a	reset credentials	Reset credentials for a user if they forgot their password or something	ba1a6f7d-badd-4ac5-9ce3-3a5dc0dd1d0b	basic-flow	t	t
219b5cae-1ac4-4710-bce0-e71c96c9a27f	Reset - Conditional OTP	Flow to determine if the OTP should be reset or not. Set to REQUIRED to force.	ba1a6f7d-badd-4ac5-9ce3-3a5dc0dd1d0b	basic-flow	f	t
903d0900-b5b6-4055-8075-957d04292a1b	clients	Base authentication for clients	ba1a6f7d-badd-4ac5-9ce3-3a5dc0dd1d0b	client-flow	t	t
15dd702f-e336-4365-9158-2b372262564c	first broker login	Actions taken after first broker login with identity provider account, which is not yet linked to any Keycloak account	ba1a6f7d-badd-4ac5-9ce3-3a5dc0dd1d0b	basic-flow	t	t
d37ee4f2-3e4f-44a5-901f-9a336a0a45a7	User creation or linking	Flow for the existing/non-existing user alternatives	ba1a6f7d-badd-4ac5-9ce3-3a5dc0dd1d0b	basic-flow	f	t
4013ec87-0ff1-43dc-a227-b3bb40c8832c	Handle Existing Account	Handle what to do if there is existing account with same email/username like authenticated identity provider	ba1a6f7d-badd-4ac5-9ce3-3a5dc0dd1d0b	basic-flow	f	t
ca90292d-53d5-492a-a230-e5c72767f75e	Account verification options	Method with which to verity the existing account	ba1a6f7d-badd-4ac5-9ce3-3a5dc0dd1d0b	basic-flow	f	t
f50c497c-bb30-49ef-859d-de81654535f9	Verify Existing Account by Re-authentication	Reauthentication of existing account	ba1a6f7d-badd-4ac5-9ce3-3a5dc0dd1d0b	basic-flow	f	t
bcc0a2fa-490f-4da0-b4c9-a65eec3a104c	First broker login - Conditional OTP	Flow to determine if the OTP is required for the authentication	ba1a6f7d-badd-4ac5-9ce3-3a5dc0dd1d0b	basic-flow	f	t
bef25de2-6c10-4209-b35f-a79c71db0155	saml ecp	SAML ECP Profile Authentication Flow	ba1a6f7d-badd-4ac5-9ce3-3a5dc0dd1d0b	basic-flow	t	t
e3935ad1-5899-48a5-be90-c4956388f55e	docker auth	Used by Docker clients to authenticate against the IDP	ba1a6f7d-badd-4ac5-9ce3-3a5dc0dd1d0b	basic-flow	t	t
56539a41-0362-4c27-abc7-8b3005d5b501	http challenge	An authentication flow based on challenge-response HTTP Authentication Schemes	ba1a6f7d-badd-4ac5-9ce3-3a5dc0dd1d0b	basic-flow	t	t
de921f34-6628-46cf-96cf-9c536e9657aa	Authentication Options	Authentication options.	ba1a6f7d-badd-4ac5-9ce3-3a5dc0dd1d0b	basic-flow	f	t
\.


--
-- Data for Name: authenticator_config; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.authenticator_config (id, alias, realm_id) FROM stdin;
63b63a8b-7aba-4408-a479-9fd64e59a548	review profile config	d86ec37e-5c02-4219-bb0d-99cb545457ff
7d6d0243-e2c8-420e-9672-d4b96e16c2cd	create unique user config	d86ec37e-5c02-4219-bb0d-99cb545457ff
6eb438e3-bab6-4f50-a96d-71842e021e24	review profile config	ba1a6f7d-badd-4ac5-9ce3-3a5dc0dd1d0b
eab61f48-a114-4024-a79e-a73aa0428019	create unique user config	ba1a6f7d-badd-4ac5-9ce3-3a5dc0dd1d0b
\.


--
-- Data for Name: authenticator_config_entry; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.authenticator_config_entry (authenticator_id, value, name) FROM stdin;
63b63a8b-7aba-4408-a479-9fd64e59a548	missing	update.profile.on.first.login
7d6d0243-e2c8-420e-9672-d4b96e16c2cd	false	require.password.update.after.registration
6eb438e3-bab6-4f50-a96d-71842e021e24	missing	update.profile.on.first.login
eab61f48-a114-4024-a79e-a73aa0428019	false	require.password.update.after.registration
\.


--
-- Data for Name: broker_link; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.broker_link (identity_provider, storage_provider_id, realm_id, broker_user_id, broker_username, token, user_id) FROM stdin;
\.


--
-- Data for Name: client; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client (id, enabled, full_scope_allowed, client_id, not_before, public_client, secret, base_url, bearer_only, management_url, surrogate_auth_required, realm_id, protocol, node_rereg_timeout, frontchannel_logout, consent_required, name, service_accounts_enabled, client_authenticator_type, root_url, description, registration_token, standard_flow_enabled, implicit_flow_enabled, direct_access_grants_enabled, always_display_in_console) FROM stdin;
5debe463-9857-47f1-8f77-552084601bcb	t	f	master-realm	0	f	\N	\N	t	\N	f	d86ec37e-5c02-4219-bb0d-99cb545457ff	\N	0	f	f	master Realm	f	client-secret	\N	\N	\N	t	f	f	f
2d9b5f65-2907-4e43-b54d-b5f405769ed0	t	f	account	0	t	\N	/realms/master/account/	f	\N	f	d86ec37e-5c02-4219-bb0d-99cb545457ff	openid-connect	0	f	f	${client_account}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
b0c07851-5a13-4c04-8167-eb74fe4bf073	t	f	account-console	0	t	\N	/realms/master/account/	f	\N	f	d86ec37e-5c02-4219-bb0d-99cb545457ff	openid-connect	0	f	f	${client_account-console}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
27552099-1c6e-45c0-bced-7962d9ee6a24	t	f	broker	0	f	\N	\N	t	\N	f	d86ec37e-5c02-4219-bb0d-99cb545457ff	openid-connect	0	f	f	${client_broker}	f	client-secret	\N	\N	\N	t	f	f	f
e12365ba-b577-4fb1-acec-d10e2a6fd9a0	t	f	security-admin-console	0	t	\N	/admin/master/console/	f	\N	f	d86ec37e-5c02-4219-bb0d-99cb545457ff	openid-connect	0	f	f	${client_security-admin-console}	f	client-secret	${authAdminUrl}	\N	\N	t	f	f	f
0f316262-89c6-4dfa-99d9-9ba6fb78d4b1	t	f	admin-cli	0	t	\N	\N	f	\N	f	d86ec37e-5c02-4219-bb0d-99cb545457ff	openid-connect	0	f	f	${client_admin-cli}	f	client-secret	\N	\N	\N	f	f	t	f
d3a1c55d-68b9-41f2-ad98-a8bcb669d6aa	t	f	poc-realm-realm	0	f	\N	\N	t	\N	f	d86ec37e-5c02-4219-bb0d-99cb545457ff	\N	0	f	f	poc-realm Realm	f	client-secret	\N	\N	\N	t	f	f	f
15b9a376-d8eb-4797-a671-890e4fbe85f6	t	f	realm-management	0	f	\N	\N	t	\N	f	ba1a6f7d-badd-4ac5-9ce3-3a5dc0dd1d0b	openid-connect	0	f	f	${client_realm-management}	f	client-secret	\N	\N	\N	t	f	f	f
6899b2e9-8cdb-41ad-b45f-c4a40fd40621	t	f	account	0	t	\N	/realms/poc-realm/account/	f	\N	f	ba1a6f7d-badd-4ac5-9ce3-3a5dc0dd1d0b	openid-connect	0	f	f	${client_account}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
7a7e6753-8234-49ad-8473-0425c343131c	t	f	account-console	0	t	\N	/realms/poc-realm/account/	f	\N	f	ba1a6f7d-badd-4ac5-9ce3-3a5dc0dd1d0b	openid-connect	0	f	f	${client_account-console}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
6091eac0-f623-46e9-9e12-43e23d3dd79f	t	f	broker	0	f	\N	\N	t	\N	f	ba1a6f7d-badd-4ac5-9ce3-3a5dc0dd1d0b	openid-connect	0	f	f	${client_broker}	f	client-secret	\N	\N	\N	t	f	f	f
33b7bec8-88a8-4526-81f1-4c14bc121bf2	t	f	security-admin-console	0	t	\N	/admin/poc-realm/console/	f	\N	f	ba1a6f7d-badd-4ac5-9ce3-3a5dc0dd1d0b	openid-connect	0	f	f	${client_security-admin-console}	f	client-secret	${authAdminUrl}	\N	\N	t	f	f	f
f5e0d1e3-79d7-436e-96ac-355686f2f4f7	t	f	admin-cli	0	t	\N	\N	f	\N	f	ba1a6f7d-badd-4ac5-9ce3-3a5dc0dd1d0b	openid-connect	0	f	f	${client_admin-cli}	f	client-secret	\N	\N	\N	f	f	t	f
1ce59c97-2365-4484-80b6-3c471172f3be	t	t	poc-client-default	0	f	E8zLtm1XfMqzON9EYLF6X93VuxhO3xKi		f		f	ba1a6f7d-badd-4ac5-9ce3-3a5dc0dd1d0b	openid-connect	-1	t	f	Default PoC Client	f	client-secret			\N	t	f	t	f
\.


--
-- Data for Name: client_attributes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_attributes (client_id, value, name) FROM stdin;
2d9b5f65-2907-4e43-b54d-b5f405769ed0	+	post.logout.redirect.uris
b0c07851-5a13-4c04-8167-eb74fe4bf073	+	post.logout.redirect.uris
b0c07851-5a13-4c04-8167-eb74fe4bf073	S256	pkce.code.challenge.method
e12365ba-b577-4fb1-acec-d10e2a6fd9a0	+	post.logout.redirect.uris
e12365ba-b577-4fb1-acec-d10e2a6fd9a0	S256	pkce.code.challenge.method
6899b2e9-8cdb-41ad-b45f-c4a40fd40621	+	post.logout.redirect.uris
7a7e6753-8234-49ad-8473-0425c343131c	+	post.logout.redirect.uris
7a7e6753-8234-49ad-8473-0425c343131c	S256	pkce.code.challenge.method
33b7bec8-88a8-4526-81f1-4c14bc121bf2	+	post.logout.redirect.uris
33b7bec8-88a8-4526-81f1-4c14bc121bf2	S256	pkce.code.challenge.method
1ce59c97-2365-4484-80b6-3c471172f3be	*	post.logout.redirect.uris
1ce59c97-2365-4484-80b6-3c471172f3be	false	oauth2.device.authorization.grant.enabled
1ce59c97-2365-4484-80b6-3c471172f3be	false	use.jwks.url
1ce59c97-2365-4484-80b6-3c471172f3be	false	backchannel.logout.revoke.offline.tokens
1ce59c97-2365-4484-80b6-3c471172f3be	true	use.refresh.tokens
1ce59c97-2365-4484-80b6-3c471172f3be	false	tls-client-certificate-bound-access-tokens
1ce59c97-2365-4484-80b6-3c471172f3be	false	oidc.ciba.grant.enabled
1ce59c97-2365-4484-80b6-3c471172f3be	true	backchannel.logout.session.required
1ce59c97-2365-4484-80b6-3c471172f3be	false	client_credentials.use_refresh_token
1ce59c97-2365-4484-80b6-3c471172f3be	{}	acr.loa.map
1ce59c97-2365-4484-80b6-3c471172f3be	false	require.pushed.authorization.requests
1ce59c97-2365-4484-80b6-3c471172f3be	false	display.on.consent.screen
1ce59c97-2365-4484-80b6-3c471172f3be	false	token.response.type.bearer.lower-case
1ce59c97-2365-4484-80b6-3c471172f3be	1661337997	client.secret.creation.time
\.


--
-- Data for Name: client_auth_flow_bindings; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_auth_flow_bindings (client_id, flow_id, binding_name) FROM stdin;
\.


--
-- Data for Name: client_initial_access; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_initial_access (id, realm_id, "timestamp", expiration, count, remaining_count) FROM stdin;
\.


--
-- Data for Name: client_node_registrations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_node_registrations (client_id, value, name) FROM stdin;
\.


--
-- Data for Name: client_scope; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_scope (id, name, realm_id, description, protocol) FROM stdin;
8f3ad643-c03d-4e51-8b7d-1505759ec264	offline_access	d86ec37e-5c02-4219-bb0d-99cb545457ff	OpenID Connect built-in scope: offline_access	openid-connect
35336663-16ef-418f-a063-1cfd0363c77b	role_list	d86ec37e-5c02-4219-bb0d-99cb545457ff	SAML role list	saml
d0004cee-7d50-4c70-98b0-c2ab20de8c24	profile	d86ec37e-5c02-4219-bb0d-99cb545457ff	OpenID Connect built-in scope: profile	openid-connect
b0fc516e-9351-46b4-8c8d-08fdddfab057	email	d86ec37e-5c02-4219-bb0d-99cb545457ff	OpenID Connect built-in scope: email	openid-connect
9cac0c30-60d3-436d-8444-00f046b7e5ca	address	d86ec37e-5c02-4219-bb0d-99cb545457ff	OpenID Connect built-in scope: address	openid-connect
f013df01-3a46-4633-b587-79af1d435e3b	phone	d86ec37e-5c02-4219-bb0d-99cb545457ff	OpenID Connect built-in scope: phone	openid-connect
b09bf549-596a-4034-9329-04375128a29f	roles	d86ec37e-5c02-4219-bb0d-99cb545457ff	OpenID Connect scope for add user roles to the access token	openid-connect
086d7bf5-cfff-4609-8aba-5461aea83734	web-origins	d86ec37e-5c02-4219-bb0d-99cb545457ff	OpenID Connect scope for add allowed web origins to the access token	openid-connect
f1537516-3935-4b25-a382-71055478cbff	microprofile-jwt	d86ec37e-5c02-4219-bb0d-99cb545457ff	Microprofile - JWT built-in scope	openid-connect
db4509b6-791c-40e4-bba6-a85e67b9a25e	acr	d86ec37e-5c02-4219-bb0d-99cb545457ff	OpenID Connect scope for add acr (authentication context class reference) to the token	openid-connect
eb81543f-1bb5-4bb9-84bd-217231dc6914	offline_access	ba1a6f7d-badd-4ac5-9ce3-3a5dc0dd1d0b	OpenID Connect built-in scope: offline_access	openid-connect
54a89283-5d57-478d-bf78-c6b557b19f94	role_list	ba1a6f7d-badd-4ac5-9ce3-3a5dc0dd1d0b	SAML role list	saml
8dcda776-69c3-41df-a9fe-82ad55a65537	profile	ba1a6f7d-badd-4ac5-9ce3-3a5dc0dd1d0b	OpenID Connect built-in scope: profile	openid-connect
c11595f8-0c6a-4325-9610-cceb12f45a0e	email	ba1a6f7d-badd-4ac5-9ce3-3a5dc0dd1d0b	OpenID Connect built-in scope: email	openid-connect
d56fa960-c2d6-48e9-ba20-dd229d6419d7	address	ba1a6f7d-badd-4ac5-9ce3-3a5dc0dd1d0b	OpenID Connect built-in scope: address	openid-connect
65b8f3f8-bbac-4f62-91e0-583f4acd826a	phone	ba1a6f7d-badd-4ac5-9ce3-3a5dc0dd1d0b	OpenID Connect built-in scope: phone	openid-connect
a261d167-16bd-4e94-8067-957670b876a0	roles	ba1a6f7d-badd-4ac5-9ce3-3a5dc0dd1d0b	OpenID Connect scope for add user roles to the access token	openid-connect
ebbd03b4-43c2-4d7d-80ab-4f62aeffd088	web-origins	ba1a6f7d-badd-4ac5-9ce3-3a5dc0dd1d0b	OpenID Connect scope for add allowed web origins to the access token	openid-connect
0d56fbd7-1120-41df-96ec-760c3cd9f088	microprofile-jwt	ba1a6f7d-badd-4ac5-9ce3-3a5dc0dd1d0b	Microprofile - JWT built-in scope	openid-connect
53149023-1608-4a72-b605-a330acf727d1	acr	ba1a6f7d-badd-4ac5-9ce3-3a5dc0dd1d0b	OpenID Connect scope for add acr (authentication context class reference) to the token	openid-connect
\.


--
-- Data for Name: client_scope_attributes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_scope_attributes (scope_id, value, name) FROM stdin;
8f3ad643-c03d-4e51-8b7d-1505759ec264	true	display.on.consent.screen
8f3ad643-c03d-4e51-8b7d-1505759ec264	${offlineAccessScopeConsentText}	consent.screen.text
35336663-16ef-418f-a063-1cfd0363c77b	true	display.on.consent.screen
35336663-16ef-418f-a063-1cfd0363c77b	${samlRoleListScopeConsentText}	consent.screen.text
d0004cee-7d50-4c70-98b0-c2ab20de8c24	true	display.on.consent.screen
d0004cee-7d50-4c70-98b0-c2ab20de8c24	${profileScopeConsentText}	consent.screen.text
d0004cee-7d50-4c70-98b0-c2ab20de8c24	true	include.in.token.scope
b0fc516e-9351-46b4-8c8d-08fdddfab057	true	display.on.consent.screen
b0fc516e-9351-46b4-8c8d-08fdddfab057	${emailScopeConsentText}	consent.screen.text
b0fc516e-9351-46b4-8c8d-08fdddfab057	true	include.in.token.scope
9cac0c30-60d3-436d-8444-00f046b7e5ca	true	display.on.consent.screen
9cac0c30-60d3-436d-8444-00f046b7e5ca	${addressScopeConsentText}	consent.screen.text
9cac0c30-60d3-436d-8444-00f046b7e5ca	true	include.in.token.scope
f013df01-3a46-4633-b587-79af1d435e3b	true	display.on.consent.screen
f013df01-3a46-4633-b587-79af1d435e3b	${phoneScopeConsentText}	consent.screen.text
f013df01-3a46-4633-b587-79af1d435e3b	true	include.in.token.scope
b09bf549-596a-4034-9329-04375128a29f	true	display.on.consent.screen
b09bf549-596a-4034-9329-04375128a29f	${rolesScopeConsentText}	consent.screen.text
b09bf549-596a-4034-9329-04375128a29f	false	include.in.token.scope
086d7bf5-cfff-4609-8aba-5461aea83734	false	display.on.consent.screen
086d7bf5-cfff-4609-8aba-5461aea83734		consent.screen.text
086d7bf5-cfff-4609-8aba-5461aea83734	false	include.in.token.scope
f1537516-3935-4b25-a382-71055478cbff	false	display.on.consent.screen
f1537516-3935-4b25-a382-71055478cbff	true	include.in.token.scope
db4509b6-791c-40e4-bba6-a85e67b9a25e	false	display.on.consent.screen
db4509b6-791c-40e4-bba6-a85e67b9a25e	false	include.in.token.scope
eb81543f-1bb5-4bb9-84bd-217231dc6914	true	display.on.consent.screen
eb81543f-1bb5-4bb9-84bd-217231dc6914	${offlineAccessScopeConsentText}	consent.screen.text
54a89283-5d57-478d-bf78-c6b557b19f94	true	display.on.consent.screen
54a89283-5d57-478d-bf78-c6b557b19f94	${samlRoleListScopeConsentText}	consent.screen.text
8dcda776-69c3-41df-a9fe-82ad55a65537	true	display.on.consent.screen
8dcda776-69c3-41df-a9fe-82ad55a65537	${profileScopeConsentText}	consent.screen.text
8dcda776-69c3-41df-a9fe-82ad55a65537	true	include.in.token.scope
c11595f8-0c6a-4325-9610-cceb12f45a0e	true	display.on.consent.screen
c11595f8-0c6a-4325-9610-cceb12f45a0e	${emailScopeConsentText}	consent.screen.text
c11595f8-0c6a-4325-9610-cceb12f45a0e	true	include.in.token.scope
d56fa960-c2d6-48e9-ba20-dd229d6419d7	true	display.on.consent.screen
d56fa960-c2d6-48e9-ba20-dd229d6419d7	${addressScopeConsentText}	consent.screen.text
d56fa960-c2d6-48e9-ba20-dd229d6419d7	true	include.in.token.scope
65b8f3f8-bbac-4f62-91e0-583f4acd826a	true	display.on.consent.screen
65b8f3f8-bbac-4f62-91e0-583f4acd826a	${phoneScopeConsentText}	consent.screen.text
65b8f3f8-bbac-4f62-91e0-583f4acd826a	true	include.in.token.scope
a261d167-16bd-4e94-8067-957670b876a0	true	display.on.consent.screen
a261d167-16bd-4e94-8067-957670b876a0	${rolesScopeConsentText}	consent.screen.text
a261d167-16bd-4e94-8067-957670b876a0	false	include.in.token.scope
ebbd03b4-43c2-4d7d-80ab-4f62aeffd088	false	display.on.consent.screen
ebbd03b4-43c2-4d7d-80ab-4f62aeffd088		consent.screen.text
ebbd03b4-43c2-4d7d-80ab-4f62aeffd088	false	include.in.token.scope
0d56fbd7-1120-41df-96ec-760c3cd9f088	false	display.on.consent.screen
0d56fbd7-1120-41df-96ec-760c3cd9f088	true	include.in.token.scope
53149023-1608-4a72-b605-a330acf727d1	false	display.on.consent.screen
53149023-1608-4a72-b605-a330acf727d1	false	include.in.token.scope
\.


--
-- Data for Name: client_scope_client; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_scope_client (client_id, scope_id, default_scope) FROM stdin;
2d9b5f65-2907-4e43-b54d-b5f405769ed0	b0fc516e-9351-46b4-8c8d-08fdddfab057	t
2d9b5f65-2907-4e43-b54d-b5f405769ed0	086d7bf5-cfff-4609-8aba-5461aea83734	t
2d9b5f65-2907-4e43-b54d-b5f405769ed0	db4509b6-791c-40e4-bba6-a85e67b9a25e	t
2d9b5f65-2907-4e43-b54d-b5f405769ed0	d0004cee-7d50-4c70-98b0-c2ab20de8c24	t
2d9b5f65-2907-4e43-b54d-b5f405769ed0	b09bf549-596a-4034-9329-04375128a29f	t
2d9b5f65-2907-4e43-b54d-b5f405769ed0	8f3ad643-c03d-4e51-8b7d-1505759ec264	f
2d9b5f65-2907-4e43-b54d-b5f405769ed0	f013df01-3a46-4633-b587-79af1d435e3b	f
2d9b5f65-2907-4e43-b54d-b5f405769ed0	9cac0c30-60d3-436d-8444-00f046b7e5ca	f
2d9b5f65-2907-4e43-b54d-b5f405769ed0	f1537516-3935-4b25-a382-71055478cbff	f
b0c07851-5a13-4c04-8167-eb74fe4bf073	b0fc516e-9351-46b4-8c8d-08fdddfab057	t
b0c07851-5a13-4c04-8167-eb74fe4bf073	086d7bf5-cfff-4609-8aba-5461aea83734	t
b0c07851-5a13-4c04-8167-eb74fe4bf073	db4509b6-791c-40e4-bba6-a85e67b9a25e	t
b0c07851-5a13-4c04-8167-eb74fe4bf073	d0004cee-7d50-4c70-98b0-c2ab20de8c24	t
b0c07851-5a13-4c04-8167-eb74fe4bf073	b09bf549-596a-4034-9329-04375128a29f	t
b0c07851-5a13-4c04-8167-eb74fe4bf073	8f3ad643-c03d-4e51-8b7d-1505759ec264	f
b0c07851-5a13-4c04-8167-eb74fe4bf073	f013df01-3a46-4633-b587-79af1d435e3b	f
b0c07851-5a13-4c04-8167-eb74fe4bf073	9cac0c30-60d3-436d-8444-00f046b7e5ca	f
b0c07851-5a13-4c04-8167-eb74fe4bf073	f1537516-3935-4b25-a382-71055478cbff	f
0f316262-89c6-4dfa-99d9-9ba6fb78d4b1	b0fc516e-9351-46b4-8c8d-08fdddfab057	t
0f316262-89c6-4dfa-99d9-9ba6fb78d4b1	086d7bf5-cfff-4609-8aba-5461aea83734	t
0f316262-89c6-4dfa-99d9-9ba6fb78d4b1	db4509b6-791c-40e4-bba6-a85e67b9a25e	t
0f316262-89c6-4dfa-99d9-9ba6fb78d4b1	d0004cee-7d50-4c70-98b0-c2ab20de8c24	t
0f316262-89c6-4dfa-99d9-9ba6fb78d4b1	b09bf549-596a-4034-9329-04375128a29f	t
0f316262-89c6-4dfa-99d9-9ba6fb78d4b1	8f3ad643-c03d-4e51-8b7d-1505759ec264	f
0f316262-89c6-4dfa-99d9-9ba6fb78d4b1	f013df01-3a46-4633-b587-79af1d435e3b	f
0f316262-89c6-4dfa-99d9-9ba6fb78d4b1	9cac0c30-60d3-436d-8444-00f046b7e5ca	f
0f316262-89c6-4dfa-99d9-9ba6fb78d4b1	f1537516-3935-4b25-a382-71055478cbff	f
27552099-1c6e-45c0-bced-7962d9ee6a24	b0fc516e-9351-46b4-8c8d-08fdddfab057	t
27552099-1c6e-45c0-bced-7962d9ee6a24	086d7bf5-cfff-4609-8aba-5461aea83734	t
27552099-1c6e-45c0-bced-7962d9ee6a24	db4509b6-791c-40e4-bba6-a85e67b9a25e	t
27552099-1c6e-45c0-bced-7962d9ee6a24	d0004cee-7d50-4c70-98b0-c2ab20de8c24	t
27552099-1c6e-45c0-bced-7962d9ee6a24	b09bf549-596a-4034-9329-04375128a29f	t
27552099-1c6e-45c0-bced-7962d9ee6a24	8f3ad643-c03d-4e51-8b7d-1505759ec264	f
27552099-1c6e-45c0-bced-7962d9ee6a24	f013df01-3a46-4633-b587-79af1d435e3b	f
27552099-1c6e-45c0-bced-7962d9ee6a24	9cac0c30-60d3-436d-8444-00f046b7e5ca	f
27552099-1c6e-45c0-bced-7962d9ee6a24	f1537516-3935-4b25-a382-71055478cbff	f
5debe463-9857-47f1-8f77-552084601bcb	b0fc516e-9351-46b4-8c8d-08fdddfab057	t
5debe463-9857-47f1-8f77-552084601bcb	086d7bf5-cfff-4609-8aba-5461aea83734	t
5debe463-9857-47f1-8f77-552084601bcb	db4509b6-791c-40e4-bba6-a85e67b9a25e	t
5debe463-9857-47f1-8f77-552084601bcb	d0004cee-7d50-4c70-98b0-c2ab20de8c24	t
5debe463-9857-47f1-8f77-552084601bcb	b09bf549-596a-4034-9329-04375128a29f	t
5debe463-9857-47f1-8f77-552084601bcb	8f3ad643-c03d-4e51-8b7d-1505759ec264	f
5debe463-9857-47f1-8f77-552084601bcb	f013df01-3a46-4633-b587-79af1d435e3b	f
5debe463-9857-47f1-8f77-552084601bcb	9cac0c30-60d3-436d-8444-00f046b7e5ca	f
5debe463-9857-47f1-8f77-552084601bcb	f1537516-3935-4b25-a382-71055478cbff	f
e12365ba-b577-4fb1-acec-d10e2a6fd9a0	b0fc516e-9351-46b4-8c8d-08fdddfab057	t
e12365ba-b577-4fb1-acec-d10e2a6fd9a0	086d7bf5-cfff-4609-8aba-5461aea83734	t
e12365ba-b577-4fb1-acec-d10e2a6fd9a0	db4509b6-791c-40e4-bba6-a85e67b9a25e	t
e12365ba-b577-4fb1-acec-d10e2a6fd9a0	d0004cee-7d50-4c70-98b0-c2ab20de8c24	t
e12365ba-b577-4fb1-acec-d10e2a6fd9a0	b09bf549-596a-4034-9329-04375128a29f	t
e12365ba-b577-4fb1-acec-d10e2a6fd9a0	8f3ad643-c03d-4e51-8b7d-1505759ec264	f
e12365ba-b577-4fb1-acec-d10e2a6fd9a0	f013df01-3a46-4633-b587-79af1d435e3b	f
e12365ba-b577-4fb1-acec-d10e2a6fd9a0	9cac0c30-60d3-436d-8444-00f046b7e5ca	f
e12365ba-b577-4fb1-acec-d10e2a6fd9a0	f1537516-3935-4b25-a382-71055478cbff	f
6899b2e9-8cdb-41ad-b45f-c4a40fd40621	c11595f8-0c6a-4325-9610-cceb12f45a0e	t
6899b2e9-8cdb-41ad-b45f-c4a40fd40621	53149023-1608-4a72-b605-a330acf727d1	t
6899b2e9-8cdb-41ad-b45f-c4a40fd40621	a261d167-16bd-4e94-8067-957670b876a0	t
6899b2e9-8cdb-41ad-b45f-c4a40fd40621	8dcda776-69c3-41df-a9fe-82ad55a65537	t
6899b2e9-8cdb-41ad-b45f-c4a40fd40621	ebbd03b4-43c2-4d7d-80ab-4f62aeffd088	t
6899b2e9-8cdb-41ad-b45f-c4a40fd40621	d56fa960-c2d6-48e9-ba20-dd229d6419d7	f
6899b2e9-8cdb-41ad-b45f-c4a40fd40621	65b8f3f8-bbac-4f62-91e0-583f4acd826a	f
6899b2e9-8cdb-41ad-b45f-c4a40fd40621	0d56fbd7-1120-41df-96ec-760c3cd9f088	f
6899b2e9-8cdb-41ad-b45f-c4a40fd40621	eb81543f-1bb5-4bb9-84bd-217231dc6914	f
7a7e6753-8234-49ad-8473-0425c343131c	c11595f8-0c6a-4325-9610-cceb12f45a0e	t
7a7e6753-8234-49ad-8473-0425c343131c	53149023-1608-4a72-b605-a330acf727d1	t
7a7e6753-8234-49ad-8473-0425c343131c	a261d167-16bd-4e94-8067-957670b876a0	t
7a7e6753-8234-49ad-8473-0425c343131c	8dcda776-69c3-41df-a9fe-82ad55a65537	t
7a7e6753-8234-49ad-8473-0425c343131c	ebbd03b4-43c2-4d7d-80ab-4f62aeffd088	t
7a7e6753-8234-49ad-8473-0425c343131c	d56fa960-c2d6-48e9-ba20-dd229d6419d7	f
7a7e6753-8234-49ad-8473-0425c343131c	65b8f3f8-bbac-4f62-91e0-583f4acd826a	f
7a7e6753-8234-49ad-8473-0425c343131c	0d56fbd7-1120-41df-96ec-760c3cd9f088	f
7a7e6753-8234-49ad-8473-0425c343131c	eb81543f-1bb5-4bb9-84bd-217231dc6914	f
f5e0d1e3-79d7-436e-96ac-355686f2f4f7	c11595f8-0c6a-4325-9610-cceb12f45a0e	t
f5e0d1e3-79d7-436e-96ac-355686f2f4f7	53149023-1608-4a72-b605-a330acf727d1	t
f5e0d1e3-79d7-436e-96ac-355686f2f4f7	a261d167-16bd-4e94-8067-957670b876a0	t
f5e0d1e3-79d7-436e-96ac-355686f2f4f7	8dcda776-69c3-41df-a9fe-82ad55a65537	t
f5e0d1e3-79d7-436e-96ac-355686f2f4f7	ebbd03b4-43c2-4d7d-80ab-4f62aeffd088	t
f5e0d1e3-79d7-436e-96ac-355686f2f4f7	d56fa960-c2d6-48e9-ba20-dd229d6419d7	f
f5e0d1e3-79d7-436e-96ac-355686f2f4f7	65b8f3f8-bbac-4f62-91e0-583f4acd826a	f
f5e0d1e3-79d7-436e-96ac-355686f2f4f7	0d56fbd7-1120-41df-96ec-760c3cd9f088	f
f5e0d1e3-79d7-436e-96ac-355686f2f4f7	eb81543f-1bb5-4bb9-84bd-217231dc6914	f
6091eac0-f623-46e9-9e12-43e23d3dd79f	c11595f8-0c6a-4325-9610-cceb12f45a0e	t
6091eac0-f623-46e9-9e12-43e23d3dd79f	53149023-1608-4a72-b605-a330acf727d1	t
6091eac0-f623-46e9-9e12-43e23d3dd79f	a261d167-16bd-4e94-8067-957670b876a0	t
6091eac0-f623-46e9-9e12-43e23d3dd79f	8dcda776-69c3-41df-a9fe-82ad55a65537	t
6091eac0-f623-46e9-9e12-43e23d3dd79f	ebbd03b4-43c2-4d7d-80ab-4f62aeffd088	t
6091eac0-f623-46e9-9e12-43e23d3dd79f	d56fa960-c2d6-48e9-ba20-dd229d6419d7	f
6091eac0-f623-46e9-9e12-43e23d3dd79f	65b8f3f8-bbac-4f62-91e0-583f4acd826a	f
6091eac0-f623-46e9-9e12-43e23d3dd79f	0d56fbd7-1120-41df-96ec-760c3cd9f088	f
6091eac0-f623-46e9-9e12-43e23d3dd79f	eb81543f-1bb5-4bb9-84bd-217231dc6914	f
15b9a376-d8eb-4797-a671-890e4fbe85f6	c11595f8-0c6a-4325-9610-cceb12f45a0e	t
15b9a376-d8eb-4797-a671-890e4fbe85f6	53149023-1608-4a72-b605-a330acf727d1	t
15b9a376-d8eb-4797-a671-890e4fbe85f6	a261d167-16bd-4e94-8067-957670b876a0	t
15b9a376-d8eb-4797-a671-890e4fbe85f6	8dcda776-69c3-41df-a9fe-82ad55a65537	t
15b9a376-d8eb-4797-a671-890e4fbe85f6	ebbd03b4-43c2-4d7d-80ab-4f62aeffd088	t
15b9a376-d8eb-4797-a671-890e4fbe85f6	d56fa960-c2d6-48e9-ba20-dd229d6419d7	f
15b9a376-d8eb-4797-a671-890e4fbe85f6	65b8f3f8-bbac-4f62-91e0-583f4acd826a	f
15b9a376-d8eb-4797-a671-890e4fbe85f6	0d56fbd7-1120-41df-96ec-760c3cd9f088	f
15b9a376-d8eb-4797-a671-890e4fbe85f6	eb81543f-1bb5-4bb9-84bd-217231dc6914	f
33b7bec8-88a8-4526-81f1-4c14bc121bf2	c11595f8-0c6a-4325-9610-cceb12f45a0e	t
33b7bec8-88a8-4526-81f1-4c14bc121bf2	53149023-1608-4a72-b605-a330acf727d1	t
33b7bec8-88a8-4526-81f1-4c14bc121bf2	a261d167-16bd-4e94-8067-957670b876a0	t
33b7bec8-88a8-4526-81f1-4c14bc121bf2	8dcda776-69c3-41df-a9fe-82ad55a65537	t
33b7bec8-88a8-4526-81f1-4c14bc121bf2	ebbd03b4-43c2-4d7d-80ab-4f62aeffd088	t
33b7bec8-88a8-4526-81f1-4c14bc121bf2	d56fa960-c2d6-48e9-ba20-dd229d6419d7	f
33b7bec8-88a8-4526-81f1-4c14bc121bf2	65b8f3f8-bbac-4f62-91e0-583f4acd826a	f
33b7bec8-88a8-4526-81f1-4c14bc121bf2	0d56fbd7-1120-41df-96ec-760c3cd9f088	f
33b7bec8-88a8-4526-81f1-4c14bc121bf2	eb81543f-1bb5-4bb9-84bd-217231dc6914	f
1ce59c97-2365-4484-80b6-3c471172f3be	ebbd03b4-43c2-4d7d-80ab-4f62aeffd088	t
1ce59c97-2365-4484-80b6-3c471172f3be	53149023-1608-4a72-b605-a330acf727d1	t
1ce59c97-2365-4484-80b6-3c471172f3be	8dcda776-69c3-41df-a9fe-82ad55a65537	t
1ce59c97-2365-4484-80b6-3c471172f3be	a261d167-16bd-4e94-8067-957670b876a0	t
1ce59c97-2365-4484-80b6-3c471172f3be	c11595f8-0c6a-4325-9610-cceb12f45a0e	t
1ce59c97-2365-4484-80b6-3c471172f3be	d56fa960-c2d6-48e9-ba20-dd229d6419d7	f
1ce59c97-2365-4484-80b6-3c471172f3be	65b8f3f8-bbac-4f62-91e0-583f4acd826a	f
1ce59c97-2365-4484-80b6-3c471172f3be	eb81543f-1bb5-4bb9-84bd-217231dc6914	f
1ce59c97-2365-4484-80b6-3c471172f3be	0d56fbd7-1120-41df-96ec-760c3cd9f088	f
\.


--
-- Data for Name: client_scope_role_mapping; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_scope_role_mapping (scope_id, role_id) FROM stdin;
8f3ad643-c03d-4e51-8b7d-1505759ec264	7538809e-9165-4753-bb76-8968bacfa374
eb81543f-1bb5-4bb9-84bd-217231dc6914	7d88dd7c-45f1-4d3e-85e6-3e262c6b726f
\.


--
-- Data for Name: client_session; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_session (id, client_id, redirect_uri, state, "timestamp", session_id, auth_method, realm_id, auth_user_id, current_action) FROM stdin;
\.


--
-- Data for Name: client_session_auth_status; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_session_auth_status (authenticator, status, client_session) FROM stdin;
\.


--
-- Data for Name: client_session_note; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_session_note (name, value, client_session) FROM stdin;
\.


--
-- Data for Name: client_session_prot_mapper; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_session_prot_mapper (protocol_mapper_id, client_session) FROM stdin;
\.


--
-- Data for Name: client_session_role; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_session_role (role_id, client_session) FROM stdin;
\.


--
-- Data for Name: client_user_session_note; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_user_session_note (name, value, client_session) FROM stdin;
\.


--
-- Data for Name: component; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.component (id, name, parent_id, provider_id, provider_type, realm_id, sub_type) FROM stdin;
6815a6ed-35de-4110-8d63-1e43bee2e1bd	Trusted Hosts	d86ec37e-5c02-4219-bb0d-99cb545457ff	trusted-hosts	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	d86ec37e-5c02-4219-bb0d-99cb545457ff	anonymous
6b5af982-7b53-48b9-8b6b-ec75fb283253	Consent Required	d86ec37e-5c02-4219-bb0d-99cb545457ff	consent-required	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	d86ec37e-5c02-4219-bb0d-99cb545457ff	anonymous
4c76ab42-3508-4237-8ef2-ea63f1979d08	Full Scope Disabled	d86ec37e-5c02-4219-bb0d-99cb545457ff	scope	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	d86ec37e-5c02-4219-bb0d-99cb545457ff	anonymous
7c1568f8-c9f7-4d45-9006-649f46efc1a3	Max Clients Limit	d86ec37e-5c02-4219-bb0d-99cb545457ff	max-clients	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	d86ec37e-5c02-4219-bb0d-99cb545457ff	anonymous
9c9e180d-ccaf-4630-a0d4-3030610b9f17	Allowed Protocol Mapper Types	d86ec37e-5c02-4219-bb0d-99cb545457ff	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	d86ec37e-5c02-4219-bb0d-99cb545457ff	anonymous
f0fde940-8b79-41c9-8c2d-48b70f9310f0	Allowed Client Scopes	d86ec37e-5c02-4219-bb0d-99cb545457ff	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	d86ec37e-5c02-4219-bb0d-99cb545457ff	anonymous
e089f91f-b929-45c6-9bae-4d3bc7633e3d	Allowed Protocol Mapper Types	d86ec37e-5c02-4219-bb0d-99cb545457ff	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	d86ec37e-5c02-4219-bb0d-99cb545457ff	authenticated
521ff440-5d7c-4978-9bb9-e544af7b8764	Allowed Client Scopes	d86ec37e-5c02-4219-bb0d-99cb545457ff	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	d86ec37e-5c02-4219-bb0d-99cb545457ff	authenticated
86f0d2cf-1f88-4ef5-b4ce-8576952cac8a	rsa-generated	d86ec37e-5c02-4219-bb0d-99cb545457ff	rsa-generated	org.keycloak.keys.KeyProvider	d86ec37e-5c02-4219-bb0d-99cb545457ff	\N
96cd237a-f486-457a-9fef-3c7ddfebf239	rsa-enc-generated	d86ec37e-5c02-4219-bb0d-99cb545457ff	rsa-enc-generated	org.keycloak.keys.KeyProvider	d86ec37e-5c02-4219-bb0d-99cb545457ff	\N
9a2eea43-bfb9-4c8f-8ace-0ed24ed137f7	hmac-generated	d86ec37e-5c02-4219-bb0d-99cb545457ff	hmac-generated	org.keycloak.keys.KeyProvider	d86ec37e-5c02-4219-bb0d-99cb545457ff	\N
4be6f161-5937-4950-a288-014505009d0c	aes-generated	d86ec37e-5c02-4219-bb0d-99cb545457ff	aes-generated	org.keycloak.keys.KeyProvider	d86ec37e-5c02-4219-bb0d-99cb545457ff	\N
502408c2-5f33-48b8-afb3-4a432f029939	rsa-generated	ba1a6f7d-badd-4ac5-9ce3-3a5dc0dd1d0b	rsa-generated	org.keycloak.keys.KeyProvider	ba1a6f7d-badd-4ac5-9ce3-3a5dc0dd1d0b	\N
6b7390b2-a3dc-41c4-997c-10247aeb15ce	rsa-enc-generated	ba1a6f7d-badd-4ac5-9ce3-3a5dc0dd1d0b	rsa-enc-generated	org.keycloak.keys.KeyProvider	ba1a6f7d-badd-4ac5-9ce3-3a5dc0dd1d0b	\N
f1dde756-cdc5-4351-9f08-3ae992918e54	hmac-generated	ba1a6f7d-badd-4ac5-9ce3-3a5dc0dd1d0b	hmac-generated	org.keycloak.keys.KeyProvider	ba1a6f7d-badd-4ac5-9ce3-3a5dc0dd1d0b	\N
03b2cc0d-3439-46a4-ba5d-651222ea033e	aes-generated	ba1a6f7d-badd-4ac5-9ce3-3a5dc0dd1d0b	aes-generated	org.keycloak.keys.KeyProvider	ba1a6f7d-badd-4ac5-9ce3-3a5dc0dd1d0b	\N
2e47b7df-23aa-4a7f-847a-68cc7c74a19b	Trusted Hosts	ba1a6f7d-badd-4ac5-9ce3-3a5dc0dd1d0b	trusted-hosts	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	ba1a6f7d-badd-4ac5-9ce3-3a5dc0dd1d0b	anonymous
b42df04a-9a84-43fb-b79b-a0d3fdf60f79	Consent Required	ba1a6f7d-badd-4ac5-9ce3-3a5dc0dd1d0b	consent-required	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	ba1a6f7d-badd-4ac5-9ce3-3a5dc0dd1d0b	anonymous
ccc5f1fb-18d6-4900-b856-79e9fc757948	Full Scope Disabled	ba1a6f7d-badd-4ac5-9ce3-3a5dc0dd1d0b	scope	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	ba1a6f7d-badd-4ac5-9ce3-3a5dc0dd1d0b	anonymous
060443d4-863c-4011-82a7-90088c324ec8	Max Clients Limit	ba1a6f7d-badd-4ac5-9ce3-3a5dc0dd1d0b	max-clients	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	ba1a6f7d-badd-4ac5-9ce3-3a5dc0dd1d0b	anonymous
8497cf5d-d752-4324-afdd-b83580f59374	Allowed Protocol Mapper Types	ba1a6f7d-badd-4ac5-9ce3-3a5dc0dd1d0b	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	ba1a6f7d-badd-4ac5-9ce3-3a5dc0dd1d0b	anonymous
4239209e-fb23-4097-b2c0-b35222f008de	Allowed Client Scopes	ba1a6f7d-badd-4ac5-9ce3-3a5dc0dd1d0b	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	ba1a6f7d-badd-4ac5-9ce3-3a5dc0dd1d0b	anonymous
433a9b53-56cf-407f-a0b5-8bd31ead0b7b	Allowed Protocol Mapper Types	ba1a6f7d-badd-4ac5-9ce3-3a5dc0dd1d0b	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	ba1a6f7d-badd-4ac5-9ce3-3a5dc0dd1d0b	authenticated
b6406d78-f39b-4e1a-8e32-8bd929993fe0	Allowed Client Scopes	ba1a6f7d-badd-4ac5-9ce3-3a5dc0dd1d0b	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	ba1a6f7d-badd-4ac5-9ce3-3a5dc0dd1d0b	authenticated
012bb18f-bc8a-4c5a-b6d3-d55c520568fa	\N	ba1a6f7d-badd-4ac5-9ce3-3a5dc0dd1d0b	declarative-user-profile	org.keycloak.userprofile.UserProfileProvider	ba1a6f7d-badd-4ac5-9ce3-3a5dc0dd1d0b	\N
\.


--
-- Data for Name: component_config; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.component_config (id, component_id, name, value) FROM stdin;
d8141302-8045-4efb-b449-a2f55df7531d	7c1568f8-c9f7-4d45-9006-649f46efc1a3	max-clients	200
1387f52d-fa1e-49fc-ae3d-478a48da3d34	6815a6ed-35de-4110-8d63-1e43bee2e1bd	host-sending-registration-request-must-match	true
aec74816-a607-4a8f-a9d1-77d7455e26f9	6815a6ed-35de-4110-8d63-1e43bee2e1bd	client-uris-must-match	true
f4c62425-0fd4-44d9-8af2-8613fbbe3658	521ff440-5d7c-4978-9bb9-e544af7b8764	allow-default-scopes	true
1f2f9723-9549-46cf-9a85-7d6f7d816750	9c9e180d-ccaf-4630-a0d4-3030610b9f17	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
d3a8d77c-1f92-4376-b43c-4f3c519c9a56	9c9e180d-ccaf-4630-a0d4-3030610b9f17	allowed-protocol-mapper-types	saml-user-attribute-mapper
9ed75fc9-3c1e-4777-9060-566a97d3dc24	9c9e180d-ccaf-4630-a0d4-3030610b9f17	allowed-protocol-mapper-types	saml-role-list-mapper
55a54777-83e2-44f8-bd98-3617e034d36f	9c9e180d-ccaf-4630-a0d4-3030610b9f17	allowed-protocol-mapper-types	saml-user-property-mapper
bcbf682c-099b-4c08-8b24-e65b15379476	9c9e180d-ccaf-4630-a0d4-3030610b9f17	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
75ebc5c2-3681-42c2-ba82-a0dd2d6fe467	9c9e180d-ccaf-4630-a0d4-3030610b9f17	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
05799fd1-b684-4820-a014-9a0c529010a2	9c9e180d-ccaf-4630-a0d4-3030610b9f17	allowed-protocol-mapper-types	oidc-full-name-mapper
a7352531-4942-4242-aff2-6b6d0fab6841	9c9e180d-ccaf-4630-a0d4-3030610b9f17	allowed-protocol-mapper-types	oidc-address-mapper
a2dabc92-65c1-45e7-b147-46000da310c4	e089f91f-b929-45c6-9bae-4d3bc7633e3d	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
eafca426-f1a5-4847-b64c-a790f124c295	e089f91f-b929-45c6-9bae-4d3bc7633e3d	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
e2ea92b9-dee0-4650-9122-4b98c59dfb25	e089f91f-b929-45c6-9bae-4d3bc7633e3d	allowed-protocol-mapper-types	saml-user-property-mapper
e1b4cdeb-7e06-43e0-808e-103b959b05f2	e089f91f-b929-45c6-9bae-4d3bc7633e3d	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
3d3e4c01-953a-43cc-bb9c-365448dd6011	e089f91f-b929-45c6-9bae-4d3bc7633e3d	allowed-protocol-mapper-types	oidc-address-mapper
fbe439ff-4f13-43b2-a7e5-491805858b7e	e089f91f-b929-45c6-9bae-4d3bc7633e3d	allowed-protocol-mapper-types	saml-role-list-mapper
f6a6d38b-41c5-434f-a62e-e14fb35e6029	e089f91f-b929-45c6-9bae-4d3bc7633e3d	allowed-protocol-mapper-types	saml-user-attribute-mapper
b85c555d-5935-47f3-ae92-6afba3a2f893	e089f91f-b929-45c6-9bae-4d3bc7633e3d	allowed-protocol-mapper-types	oidc-full-name-mapper
0cb63c61-ac48-4ffa-a2e4-3509c524a8fa	f0fde940-8b79-41c9-8c2d-48b70f9310f0	allow-default-scopes	true
62d17ec8-da37-4316-b3a1-3d20e42eb2b1	96cd237a-f486-457a-9fef-3c7ddfebf239	algorithm	RSA-OAEP
f10ba094-0a24-4eb5-8aa0-b2e0fc1993f9	96cd237a-f486-457a-9fef-3c7ddfebf239	privateKey	MIIEpQIBAAKCAQEA1ODEBr0QgBb3W9AdTcd+TrlTB8oo9ILGp2G+L15/3sLAtaOUzeCW1ItcGDqq+RTuBINsTkRv9iJQLITJEGpqcmLdTmYFXLKSwEhUUVisvSuLyGOy0BtWoVlh4MtJ6NBwLm7UEoZB2ylt6ZerybUm/73fYeImd4xChDJ4km5qP7yCk2W50slSv6x3GuX5PkMo8n8Jmnw8vpDwFtFOINmM2XTBQDY3oNKtW838zvhk4iKw4iW4ohUV/wia5Ec8g/9/5N7YweDtZ+IiT02wK0pjuMbzp5AEdnKwHQkknWhr3EFODbk4jJ2HzdqtO4LhyEHCiR3UfzQcA5y2QySwhgCqWQIDAQABAoIBABlsECzn1jkdxQOLanx35v8axa4n99Ufav7hPtekVuvw4RewBdzCRfDzBZgFJZbiZ3xVf5EnPiGsPlvarbJOqxCm+tvadih4UOsymBMw3kwnD6XqNhgBM8rIBFbWoChz//mjlaLyspmsLGqZiNPpVNN0xuEHI2Xic60a4+hE1F5w+karG8us0rRbOCQMWJ6qZwnp0EM2bnHOl1k8+kixAvws1hyds5p1Dd64jGOj+I9gRE8wTGYn4dvXp59RDrQ+CCzS5qM5C7UdE0h0NOLPapD6C4GMU9f0lV8ohfusLF46bPeKOtoCURddp5TzpIkxRUsN5s91ejDl4ZkBg2iyH3sCgYEA/lUCRaLd3g6E4NuwYIol6F2IxPEB9J4fJzoZ86i77nkl3eesNJ2l8LR1v30q9OZTwVN1N+DSPcFrc6ShR6dMAxBuvGqGGbCU6Kg7sYfUt0fWX6ZxQCtFQIMF0Hr4C2QBHQANW3CQlfXlpkJOYr8aTin0gtviVmEPAzstdPQoDcMCgYEA1kYpJorMhEWskSbfvsbjg3ZVoG1miVdpUvuubEpQGY27IWF5kXCybQOBjEHpCZ/mj+7Vzh0232FdYzSzeyxjyz0rv9XFRACLijsx8M1I+vJ7TJjELoIVI3ZtukePGyEJtS8gaSnQ0lJ2S+N+uwe4oroFjjyWEHY2rRkaEitNGbMCgYEAp1NsXD4rtAVfXMSMhOc+y2KGMfPR8or5OgiavFi908Y2qIjcHf2+B9/iO+pwkZDbd6ydyPaLu39+XyXnycmCU93CzQlUUqB/R5YvN7yCsVZ87o8FoU8Wj7vj3maYvH290cOQBiHHrjGKNlkXUxYhi11E9bcOcQAILXsIjBJ6K5sCgYEA0MjYe/euxAvn1B+e0JOXSJdbY9B1osmLlRIrqNTYK64Qcrw56l93XAWYi4QFgB1QWVsM9aM9vnduuaW2ZQSh0H0wTeIMLvChBvYa+VnuDKeNQNtx/Sc/Vailzma/qF2Oyf67g/z8vpMfNV7cM32YiObdVvTt++hT6mKVJrMOk0UCgYEAyWimdIbAIaiE/+e/YvcBVkuLfyoCb6zPATe+tTMbZRG2wxuH+GfrXlaLViuLLtkK55Msg7vaM5r7iKBeWiDE+akQgAl2UB3UcaJOIv7+/Q24Eg2XfZszbAOorQiThhDaftLSxAqGw3K02TNvwPdfk/cB+tKyr9mOFnfKOMq1wDE=
2ca2e0d9-a369-4ecc-8c28-5f984424f662	96cd237a-f486-457a-9fef-3c7ddfebf239	priority	100
cad2229e-435f-4512-80a0-686cd9f3a258	96cd237a-f486-457a-9fef-3c7ddfebf239	keyUse	ENC
8103ff90-6e0a-4b15-a1c0-12d6962a92c9	96cd237a-f486-457a-9fef-3c7ddfebf239	certificate	MIICmzCCAYMCBgGCz3DdYjANBgkqhkiG9w0BAQsFADARMQ8wDQYDVQQDDAZtYXN0ZXIwHhcNMjIwODI0MTAzOTE2WhcNMzIwODI0MTA0MDU2WjARMQ8wDQYDVQQDDAZtYXN0ZXIwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDU4MQGvRCAFvdb0B1Nx35OuVMHyij0gsanYb4vXn/ewsC1o5TN4JbUi1wYOqr5FO4Eg2xORG/2IlAshMkQampyYt1OZgVcspLASFRRWKy9K4vIY7LQG1ahWWHgy0no0HAubtQShkHbKW3pl6vJtSb/vd9h4iZ3jEKEMniSbmo/vIKTZbnSyVK/rHca5fk+QyjyfwmafDy+kPAW0U4g2YzZdMFANjeg0q1bzfzO+GTiIrDiJbiiFRX/CJrkRzyD/3/k3tjB4O1n4iJPTbArSmO4xvOnkAR2crAdCSSdaGvcQU4NuTiMnYfN2q07guHIQcKJHdR/NBwDnLZDJLCGAKpZAgMBAAEwDQYJKoZIhvcNAQELBQADggEBAI6Imn5ycPzk+RZlqQdlWJwk4wLMMdFeDNLD65mDAa+JKWh7wBf69ETGj00/LmXWtO4t4U+tHZUL+L8fexxkXIt5/E+cddk3ki/I2m27PhgXx8yePzc8I1ikskhCHPtU6yz+oHHZj45otovWFmS5pxGW1urREsdX6ZqLTu/bkXAt03rnQZOTCrrZ9u7XNEoE2GCWjPul39RpA94zj5Vez5qqcwlKSdBAziEjIv5BUfC09rFKg17V7taCJLROoavByrJx42nLl17q0oB6Z4EIyPtlrvBFPPdWDZCSw54MD69JthOvjihbGDSlBBm1SS4ltX70unwID2Q31XhIbBbFr74=
53e02eae-d44e-4113-b4ac-53c33a528e46	9a2eea43-bfb9-4c8f-8ace-0ed24ed137f7	kid	ee64e756-1fa4-408a-82bd-4f2018172eac
c278c512-b20c-4a9c-8d8e-5ff0e74a8aa8	9a2eea43-bfb9-4c8f-8ace-0ed24ed137f7	priority	100
39377045-0a7a-4723-b241-a72db8d8e530	9a2eea43-bfb9-4c8f-8ace-0ed24ed137f7	algorithm	HS256
1ce7d173-15da-437c-bae4-bc1005fd2dd4	9a2eea43-bfb9-4c8f-8ace-0ed24ed137f7	secret	RgyPH4hTFvTYRCwLZvOZXz0iuIvF5Sbv_4FmL4dATRL-PBacCB2MeCfmaIAa9oWcy3FeCL1pvu7ttgFnCxLLzA
a90cd13c-6232-45a0-aa44-89e0f72874f4	86f0d2cf-1f88-4ef5-b4ce-8576952cac8a	keyUse	SIG
668c8b7b-7449-42e6-bdfb-5da70e347dfd	86f0d2cf-1f88-4ef5-b4ce-8576952cac8a	privateKey	MIIEowIBAAKCAQEA1B2TdnBjAQFQG/iab2kA1+ZxfzBoLncyogUMuafQPEcQqT0/t4i6IGBenWZ8PY36nvFudcPgdSfZykj4ris1/sTeRmPdLIFGhu42e3BdlTZK7ArjW1ST4zEaMnON3ralACDPbEKL15oy1eDZHj+Wqs2FsKoAc96SGdNlqkV+tb11hPfTMQk0VlzrmQ4G6w2hiEIgLMJ6i1hTY93nt0kLaMAk6AJ24T3y/a2KADbLnSsu2dyvSES0vtXCNosMGq4YWPikKNI3aS+DGtuf0LWRkEykuSO2mv+G2MdeYyPebrElaIA+nd1qkM2nhkho6HfBVGIN3nCOCYqj3vDB95qcZwIDAQABAoIBAGi+ZCO/8ru71L3DQSvT28VBd/lZQ5Dybo/gU3zYV/V0GE+iPbUZcOPtArvSMHbLBh/309aWj9/6ekswRpDnKKYyvBphVQYVnmih+EhzX9r/cPbnl4bxmIe/pxKTylJYudj62sK4h8rDS+gevMh5mSKmE6b+A/Qzy8yx/cmbwKroShvHZ1QmKryukT0b+XKR1/5KEhVWnRgo1hYC2eVZEoVGyWquocU7Lpf1HbDohbf8oyUxY98M34O/sqr3y59sG2SCcJzrnoBS/dA4ZhwnrjsNkgJ6eTDcsFSHxmA/irOvDsVumFc9CaLPprjjRcF85dS/QgB7CR6R3Zqn7IbeemUCgYEA6WmsZo9CKn6lfp2Kid3dSMrEpPcTzOrvQ8xnDVpPofKc+Vrrq7ceLKAU9CERvRKvuP7UcxlwD1k2RSwmsP9ewEj3sbVjGL2X1XsJKSNdKkLD16MWz1LLNfRbD60YnDhYVLy4orfkziHFLtYT0m+GRLIpbn8BUJQx/WaIVvC01CUCgYEA6KROcv/YC/OzeJ0BqqqbdfLBF6d5xyzM84zvoCcrBODLcT7xIPAgIdkhhWHbufqS2bCk4U0J2tSnz5KErE4b0C9QeSRpUG9b3+SmFGjuFbebO1lC299jgP9hf6gOG1W7uhxUbnlm6Rw+oC483Wgj8tt1xps/p4IZE7l6gPTIYpsCgYA9HMzlwWZ6h9Q+1XK7bBqO/4ADDSnjAjQJFVB5/4ZQCZyt8O85c2V0G6nAzZO+ZFEb56SqSiO78Qizjb7HouUlBTXNEofSp3lEjMU2PysacIakQ/Ap8iyAgO0CqriB1oLSFONmvy0qB0+AVs6zzz1haSBN7PTkKxj3lsvlr3o4/QKBgF429GJURH2Ko1ssUpl4YF8jAZn/xCyqcxILOJwmYKCoHRvuvp51QL4UfiPTXrXxyXkJtaxck6ogxxkkIEDbnR3xm2iEG3Zssst4gN3xJMJ8ygv9+TqsPFLomeal+5iMXutfP75BwjCTtLUQJKwR2cUnpYnaI6xF3rwDOJ5zA5gTAoGBAIfUZickN/TEhxxbFVtvCoX4EEDofyZpDgGBeHIrzbdJ+mkrCnO/hcrcteS6NJR8OdofbQvFjtoZ2cdCj9iLB07bxwljpMvVp8vK2EZlcruxReJt1LBtwDdDErhhqbiYxR7X3txzQCNyxbRiSq8FW1ArESQ/bJFiKJTCDudbNN/q
95bd8d6a-fd5e-4b1b-9f1d-22c00b25e34e	86f0d2cf-1f88-4ef5-b4ce-8576952cac8a	certificate	MIICmzCCAYMCBgGCz3DcrjANBgkqhkiG9w0BAQsFADARMQ8wDQYDVQQDDAZtYXN0ZXIwHhcNMjIwODI0MTAzOTE2WhcNMzIwODI0MTA0MDU2WjARMQ8wDQYDVQQDDAZtYXN0ZXIwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDUHZN2cGMBAVAb+JpvaQDX5nF/MGgudzKiBQy5p9A8RxCpPT+3iLogYF6dZnw9jfqe8W51w+B1J9nKSPiuKzX+xN5GY90sgUaG7jZ7cF2VNkrsCuNbVJPjMRoyc43etqUAIM9sQovXmjLV4NkeP5aqzYWwqgBz3pIZ02WqRX61vXWE99MxCTRWXOuZDgbrDaGIQiAswnqLWFNj3ee3SQtowCToAnbhPfL9rYoANsudKy7Z3K9IRLS+1cI2iwwarhhY+KQo0jdpL4Ma25/QtZGQTKS5I7aa/4bYx15jI95usSVogD6d3WqQzaeGSGjod8FUYg3ecI4JiqPe8MH3mpxnAgMBAAEwDQYJKoZIhvcNAQELBQADggEBAAwFJiri1Rlqgx/VBvgGoQOX/r1pLxJqFqqA/KBF+Jmt/qi3R/trG3oYuLX+c2XFKiG6t6NOe9VzSkkTdkr6ABiDvDwgysRdIT37c/96pcQUrX6Rh/qTNNPIyXoLhz+a+XjD8qRPeqoEuxCQrF2NGcP0dw1kahRjkVSKOLq/HKB9rNmAa4/0Eu53cCzDVowKxSuR3DHfTo2Pz0d7qWTOD+NgxhbqGEkig/fqlHi6s/bLnnV05IMot8cQLqE4RkhvsWQ7wCTDk8R2+2k9aDFi/YldAMl6ozLcMgBMLNggf7E1CLN8SWAvPzD0UVbld3hFLoDBvkpxWy9izKGD8AJH9Hs=
510b7623-4e58-4d6e-aa06-d297bd6a4abb	86f0d2cf-1f88-4ef5-b4ce-8576952cac8a	priority	100
52259368-30d1-40d9-896f-b3f2e238e8a4	4be6f161-5937-4950-a288-014505009d0c	secret	3UkAVaZd9Qld5tkpuSU3hg
080fb3f1-90b2-4339-acbf-a6cd258523c0	4be6f161-5937-4950-a288-014505009d0c	kid	ebe473ee-c294-4af2-b06b-2758df15d051
6ccc9e5b-6333-45d4-ae34-3667ef0e21e4	4be6f161-5937-4950-a288-014505009d0c	priority	100
fc836579-737c-49ac-8801-be03c9007192	6b7390b2-a3dc-41c4-997c-10247aeb15ce	keyUse	ENC
1db8b6e1-0361-4a9d-9628-d3acf1851efc	6b7390b2-a3dc-41c4-997c-10247aeb15ce	privateKey	MIIEpAIBAAKCAQEApPuYl02qC3nqEBY2ko4OuLGy3EZRGWabCt9wuIXP2ozfMEUTnhRDiJGlElpumT5yFIEPf1phWGTfBtYY1CP/GxC3/VvDGvptoQXml+26miK1j3zxfUpT7NR3MKI0YEuRyttKxuo7+GPCn22EXL3D5h/zzRux/SUf3u7e1DFdmKO0D6uPAkJCg2csTjYMmEUpMke5wDyki/HqZwaas1T0Uuwd7HGmkxQASFqm3QJtTlIao5+RhzIxOPCfkc7liGtY7f2A9yaVSXluPe6pRT74wPLpZ2Ed45qMLLjHbmxX2Wiw0B+UbvF+zuPihlDk2SknWtjrlyW55CeNC1F0Mf5inQIDAQABAoIBABGD84qGsImo3xBnp1IOWmJB3V0U6wnBEq9IEwnIDQ3lHFHd14wWFyhh3A5Tgv/qeQaTwB8za3fMt7/cTYUCMFSBhSMVEaTk1uw8OePB1aiFDFUIPQQh9sCDOwczBU/+3eLVPr5ZAlZn0vMFl8KX0/szw7iwGsinHxfWMNqCxi7M8M2f/pPmGaCAo5I3cd9j1+H9vKyeaVQbYHlG3OJ2FCa7IUaDG5FKH7PbVgWSl9Tb1r6EvCfqmOs/+VqagKgREPoeMs3Z/64P+pkT7aZemcO067XvcFpev3VVONAgY+OndriU44WSjNSttln6eqYxZxP6jgSbQNdriVTyUykmy2ECgYEA0L5U5K8kHj+Hofe6hbPDRGdE1GCzAteAFvDfCLsK1UPWgR//FimYzbe1J9YMXjkhMc1u06u4I7ZbW6ucjMLGCI9iTZg2UwIu9jl29sHLwMiVTIAt6zOWhgZQ1Y1SZaKEm4P8pWHZS9Ta2s2WebeHQ2t5nxGk65MwxSExoOG+WmECgYEAylUgYzA4xR9fm04Qv7eQvTM5eRq7Cb88aHg2Ofm50CTUByBqIq3fkgt9RrMfeTl//k0+6O/cOVGBJQIZwlbaMZzTqcVABqu2gc1sa8H/vxn15SJSV6BGCbKXg3L9Q9ku7P9mSimY/5OzplTUs+cQfamkyJerTejl5t4iEN6wSb0CgYEAzq7F67AmePS6XPqmal/1RbNiiU49sOCjaROSIljgfw0uRKfjsJP7QiVVb14W3OyAG4mm5FqwdlvG1Vt0JENuRWeDFAVUNJiC2zVGv0hfcECq4xY/YRSxQ37ZZrkJDqz90+W5sB7UQqs9D0xkY5v+iBjQUVntC3uv3F/jfcJG8cECgYA1RkTI2SGZhbE+y0dNs5/AsYQohwlIf7oAJ+bfTQnH7GqHldlcWDvN0Iij3PYkjSdOZjhyTPXHgdZnUC5IJWY+OfThdrZtCzl65APwO5yDTOqZ8neL6v+F/ig2zEgzXTQl4vmj/V/zq4hZ+2wmEmkdLVXeG1FXqkMejs6ZcokoYQKBgQDI9qIAKHeUNXmRMJegKEn7fiFQQPi08bifwtITTkQ8aHPyKrfki619Ui+95jI68QnvSTTVRJDniZsPFWUQHMaftD7oTWUyFOf1UMhssvAsl2R7kXHKay4XTtYJNkD5ceMug5z4YXUc8iR/edH4Ss0UV0e9pDOlPGqJDFnj6sAIyg==
353218c9-80be-4d23-9d49-ad1723248ed6	6b7390b2-a3dc-41c4-997c-10247aeb15ce	certificate	MIICoTCCAYkCBgGCz3GfNDANBgkqhkiG9w0BAQsFADAUMRIwEAYDVQQDDAlwb2MtcmVhbG0wHhcNMjIwODI0MTA0MDA2WhcNMzIwODI0MTA0MTQ2WjAUMRIwEAYDVQQDDAlwb2MtcmVhbG0wggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCk+5iXTaoLeeoQFjaSjg64sbLcRlEZZpsK33C4hc/ajN8wRROeFEOIkaUSWm6ZPnIUgQ9/WmFYZN8G1hjUI/8bELf9W8Ma+m2hBeaX7bqaIrWPfPF9SlPs1HcwojRgS5HK20rG6jv4Y8KfbYRcvcPmH/PNG7H9JR/e7t7UMV2Yo7QPq48CQkKDZyxONgyYRSkyR7nAPKSL8epnBpqzVPRS7B3scaaTFABIWqbdAm1OUhqjn5GHMjE48J+RzuWIa1jt/YD3JpVJeW497qlFPvjA8ulnYR3jmowsuMdubFfZaLDQH5Ru8X7O4+KGUOTZKSda2OuXJbnkJ40LUXQx/mKdAgMBAAEwDQYJKoZIhvcNAQELBQADggEBAAqKMTCXdZCD0UNwyqdhr4LfzzXDvBz/xJL8fa694J4DUC+rZjhNJ+tCpq3AaGW4+isjfLlISsPAHf/KsDMyund6Mlkhs9gRslAp8wdxNa1huwzXXinUePOPYD4D/NrcUYTjiDh0uF+kTcikQp8Tt0TbN/V9Fya6kYaviTLVo0S8A2kbJRNx/ASVOLeTUiUZWKsJX43VUfFH5MdmWPgkQsrIledReaMVTptzXYqKA6cb6h1gxRyZQE3pdv1bOrS9nVgMhi21D+jDLlFFNfjDlZVjAeQgIqWrtVUYmX1MuJTpGyqTdmFuJARJEmVCHkBNvnjOcE1KwFfWb5JwV0ez7oU=
0020c4d4-6575-4bf9-88bc-43bd71b4c3ff	6b7390b2-a3dc-41c4-997c-10247aeb15ce	priority	100
b0a264d1-320e-404e-b489-bc9aea4fb361	6b7390b2-a3dc-41c4-997c-10247aeb15ce	algorithm	RSA-OAEP
c973794a-239a-4257-bb38-094f812ba117	03b2cc0d-3439-46a4-ba5d-651222ea033e	secret	a3xnXRv-KY3bahS4aZPEaQ
6b584aca-92b0-4c3b-9ac4-8e606c1f8c45	03b2cc0d-3439-46a4-ba5d-651222ea033e	priority	100
4ffd68bb-cb3f-4c2a-8ae2-a4bdf2b79de1	03b2cc0d-3439-46a4-ba5d-651222ea033e	kid	3e6e82f6-4502-4067-87b8-7b6601f41211
4ca332fa-acc8-4282-ab38-6c68bdcbe150	f1dde756-cdc5-4351-9f08-3ae992918e54	priority	100
5c2a7440-8ab4-44d2-9736-ea75b2e6230e	f1dde756-cdc5-4351-9f08-3ae992918e54	kid	07a527c5-3325-41f8-8b0c-4a8f4392370a
e0755a32-93f6-44bb-b4bb-05deb5c4878d	f1dde756-cdc5-4351-9f08-3ae992918e54	algorithm	HS256
46a8414b-3302-4691-b979-bdb42dd59ffe	f1dde756-cdc5-4351-9f08-3ae992918e54	secret	KDqqA2oe8Pi58PMW_OrPWJQCHHJObecv735KgocvCCgUAnTT6tFewFlPsXrcvpq_IlXBnYmA0Ys3KTYjXxLD8Q
a6a794a5-be42-46c0-a4cf-e0f8a50b300b	502408c2-5f33-48b8-afb3-4a432f029939	keyUse	SIG
4c7ac6b3-00e4-4786-87da-a8c9bdb71362	502408c2-5f33-48b8-afb3-4a432f029939	priority	100
19fc6d2e-4077-4a6a-872a-b26b493a9bdb	502408c2-5f33-48b8-afb3-4a432f029939	privateKey	MIIEogIBAAKCAQEA522eD4NxuBVTIlYBxLXP4xbhqv8aABpa0KZMLy3ksFhHsqq/gfrvW4wzA3VnKONb988PBQ4D9xtoXq7y//1NORs0gVIRmDMVkdjkIqtCOradac98IEY2FX3Cxve5FcNVe055p5MR2N8fGssVkliPrdrvgtRwnOSEX/vgXT73nm1duq9IOTIhmvPyzF5S3ge1ckccJy9+JNOTYNwmUpRh42qma/LvastH2YY2CI3wCm8fspK7ncTpeLXWs0oOgVqdPeEkJZJsmOd5TBS29h/DTImCC27nljNmZn2tgy6U/RQj2Pj4HxiBCsmijEhoGwWCuF/miyfAE/9O0rh0wPQU1wIDAQABAoIBAAS++r7Wsz5TMaFCokamc9z0WyxmjuHxqGse/fD5v/bd2JqRZdwEiWQXO/SWM8di4j/yvxwbbXlj1oAalmEpkKvbIviD9lhos8iJ6iPL30/U7uV8m88NoY5PRe9OpT0NBHPC6DvHiFYqPTkPcSHPLyMhmkfUk3qkNRLC15cR84IMMiPQQ804OahbvmW3Zok6GBUD6D91ZdCZ/Nb0xuC/buxHR+3TRiM84zbcdtMlQ+0BDreE2hGqGzfY7sPc2IBmbyJdfhSh/up3DyVsIq1wpnuT1D6/XR/Gn2UfB1+my7EJ6FxFBg9oGspPlT/6Cx/0USwNL28cTYAo2W/nPKjKPAECgYEA91C7u/14mTHD53tS6zBjEQ6gNl9tNhSFmFhxh1DoM+XeKdntgZB5r5JmmTUI56hMjDeaeopatn1ka+pwpawt3TuOswHs1Zko08jLVw7vvuo8IKRj7cZWVnW5Z5TzxVpba88ByzDqWrlzbgmD414x7LiLtPZdwHNnCegBc3kN3mkCgYEA744Qks7EadLTVC5qmFIYM8wI8VRl2TTp5YUPmugW6LZFlwa+lDtELOWpMjviKXmRGv1WbYyGOLRuokCK3Sq1+0kPTzXrAlb80NmEyL7vRRo+LRoqPQYByqfsj1MmXWGnsMReWc0Bim3WSe2RpFtotGfCxJKNsRAlreqWIsyucT8CgYBvpOlq3uzfM0D9sYVoGIrQO2sFwKRbgn4gnOR7MoHwU7er6u41zBOyt4NLbE6dzTLpJXy+DtEOiqKXuNirYYO+2FD97EOO1TpCCOYKYfrGk5UbIzrdLujw1OoioXI+SCD3FRb5NBbHZ+p85Ry9ulsNQu4GfiUqaK4+IZbuGtqw6QKBgBHpKUwQsZbH8I0Gu2mQGcclpjWE/ehzkFlczYHjgHL9zc4w7ubeV4aT1UawO4SmVjcSYffm3dI3i14OPVOz8c9L8x0VBvEx1801tjvcKr+b6rIslqPhYxjn3UQKD4BD4OnShMtqDIdxFuiIHq+PNhDnAST5YCaw8mBCfd80Noa5AoGAcaYktglf+9H2Yfhu0aQoQizPBmtOhmsSQriZSMdKKLBIob0ZYEBMftpOugS32gR3+mJMEcbBAnDAVdDzUD941h6jPGDABnes+NcYilhas3U/3Ja/0S7LO3Nn0daaP/J5129tJ2LsMEF43X5QJjN5xJbiFoYU/Nl6DPqTuC4E/98=
8c6e9a23-2d7a-4a70-b697-b10ce0caf15b	502408c2-5f33-48b8-afb3-4a432f029939	certificate	MIICoTCCAYkCBgGCz3GetzANBgkqhkiG9w0BAQsFADAUMRIwEAYDVQQDDAlwb2MtcmVhbG0wHhcNMjIwODI0MTA0MDA2WhcNMzIwODI0MTA0MTQ2WjAUMRIwEAYDVQQDDAlwb2MtcmVhbG0wggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDnbZ4Pg3G4FVMiVgHEtc/jFuGq/xoAGlrQpkwvLeSwWEeyqr+B+u9bjDMDdWco41v3zw8FDgP3G2hervL//U05GzSBUhGYMxWR2OQiq0I6tp1pz3wgRjYVfcLG97kVw1V7TnmnkxHY3x8ayxWSWI+t2u+C1HCc5IRf++BdPveebV26r0g5MiGa8/LMXlLeB7VyRxwnL34k05Ng3CZSlGHjaqZr8u9qy0fZhjYIjfAKbx+ykrudxOl4tdazSg6BWp094SQlkmyY53lMFLb2H8NMiYILbueWM2Zmfa2DLpT9FCPY+PgfGIEKyaKMSGgbBYK4X+aLJ8AT/07SuHTA9BTXAgMBAAEwDQYJKoZIhvcNAQELBQADggEBAMxpfI1PTpulZvQxPNkVbA4+2bVcKMrMi64GIxFmuEPC3BQn3NzcQeHwOsyFMWJ32J+4Ntn70PiWaNDTal8DzOtTWmrytgvi0QjEPBMGJghqhksdRHqEPyuA6UfNrtctzapaN2q9AoQghhai0xoM82aCbCYuBQ4txKO980Oka7pD/3KYMkHCpPTKPq5ln9zsyev4xmOKEo+B9i8eOvBWoCtiC6dHsJe80Y/DJl5JmrVFS/bjJu3DPvtv7dym3aFTdZXsWQNJ0dnGSWjJyyLAIxMuK1hpwXU9HqVHf8DWxjVZVAO+MTz5hgBNTSfJOUDI/8tM3VKZMs6LHv0BC0TboJQ=
65285220-bb39-4c20-b6fa-524b9285514e	b6406d78-f39b-4e1a-8e32-8bd929993fe0	allow-default-scopes	true
482ca5b3-3756-4b3a-b22f-bc12ac7710ae	433a9b53-56cf-407f-a0b5-8bd31ead0b7b	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
b1ebb763-5fe1-4595-9ced-2fba8094133f	433a9b53-56cf-407f-a0b5-8bd31ead0b7b	allowed-protocol-mapper-types	saml-user-property-mapper
dc4421fa-c5c1-4283-84b6-2b97b40d73cf	433a9b53-56cf-407f-a0b5-8bd31ead0b7b	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
201f9059-adae-4c65-9e13-13c02f81df43	433a9b53-56cf-407f-a0b5-8bd31ead0b7b	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
55cd0ba7-d099-4cef-8e7c-1bde849c5b37	433a9b53-56cf-407f-a0b5-8bd31ead0b7b	allowed-protocol-mapper-types	oidc-address-mapper
93623f49-760a-4dce-9dc8-4bd6b4239431	433a9b53-56cf-407f-a0b5-8bd31ead0b7b	allowed-protocol-mapper-types	saml-role-list-mapper
a5385f26-2640-46b8-8153-d134848f316c	433a9b53-56cf-407f-a0b5-8bd31ead0b7b	allowed-protocol-mapper-types	oidc-full-name-mapper
0b5a2ff1-d7af-45f7-89cb-e98bdc8ace19	433a9b53-56cf-407f-a0b5-8bd31ead0b7b	allowed-protocol-mapper-types	saml-user-attribute-mapper
9818b1da-21f3-4dea-886b-05c8bd64169d	2e47b7df-23aa-4a7f-847a-68cc7c74a19b	client-uris-must-match	true
894305aa-0de5-42b7-bb67-e3b37bbd85f9	2e47b7df-23aa-4a7f-847a-68cc7c74a19b	host-sending-registration-request-must-match	true
c4029075-e801-49f3-ba14-9eb9fb8f878e	8497cf5d-d752-4324-afdd-b83580f59374	allowed-protocol-mapper-types	oidc-full-name-mapper
e0eec51d-5708-4962-bc54-2a61ec0face8	8497cf5d-d752-4324-afdd-b83580f59374	allowed-protocol-mapper-types	oidc-address-mapper
7e5dadb4-58ac-43e1-8f7c-a021dee3d618	8497cf5d-d752-4324-afdd-b83580f59374	allowed-protocol-mapper-types	saml-user-property-mapper
a419c982-372d-40cb-a4d7-eed1e12cde1c	8497cf5d-d752-4324-afdd-b83580f59374	allowed-protocol-mapper-types	saml-user-attribute-mapper
2f617875-6c88-4ff4-9c15-7d5895dfb43f	8497cf5d-d752-4324-afdd-b83580f59374	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
9ceef9f3-9512-4d66-85ef-49748159cad6	8497cf5d-d752-4324-afdd-b83580f59374	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
4acb3f7b-a5c8-49de-a3f8-dd3df349955e	8497cf5d-d752-4324-afdd-b83580f59374	allowed-protocol-mapper-types	saml-role-list-mapper
de06a714-6558-44f4-a3a4-6f9d4d31db7f	8497cf5d-d752-4324-afdd-b83580f59374	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
eabfbab8-dac4-47e9-83c0-a6290117c5e8	060443d4-863c-4011-82a7-90088c324ec8	max-clients	200
d8881af6-0d89-4c0b-9802-2672d1476b6c	4239209e-fb23-4097-b2c0-b35222f008de	allow-default-scopes	true
\.


--
-- Data for Name: composite_role; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.composite_role (composite, child_role) FROM stdin;
617981fb-0111-4a21-81f7-85d9474d1a2d	5444d1e9-d828-4e71-81a4-8f70884f1bc7
617981fb-0111-4a21-81f7-85d9474d1a2d	a796e58d-de8c-4e25-a5b7-ccfbdd454809
617981fb-0111-4a21-81f7-85d9474d1a2d	04da60a3-ff17-452e-8151-c61a8ad6805e
617981fb-0111-4a21-81f7-85d9474d1a2d	ca123419-6d3a-4b19-b64f-43e2b99f24e6
617981fb-0111-4a21-81f7-85d9474d1a2d	a053f70a-542c-4784-9e60-737ae5f8edb5
617981fb-0111-4a21-81f7-85d9474d1a2d	045b183f-69bf-48b2-98a4-7e4d954a5212
617981fb-0111-4a21-81f7-85d9474d1a2d	01a0a587-9e4b-48e3-8b40-156f9f2a651c
617981fb-0111-4a21-81f7-85d9474d1a2d	edd46e55-d553-44ad-8ae7-42a960a6fac2
617981fb-0111-4a21-81f7-85d9474d1a2d	3db0138a-514b-4497-b205-6541e7adf8f7
617981fb-0111-4a21-81f7-85d9474d1a2d	ce2995c1-8167-4cb0-855f-71560a0f0645
617981fb-0111-4a21-81f7-85d9474d1a2d	fe5bfda5-50e6-4b6a-8506-cf69b66a1759
617981fb-0111-4a21-81f7-85d9474d1a2d	7612b999-60a4-44ec-aca9-1a761de54e62
617981fb-0111-4a21-81f7-85d9474d1a2d	b414c4be-8abb-4362-ab33-3a30b6c01fcd
617981fb-0111-4a21-81f7-85d9474d1a2d	835e825b-3452-4fe1-85dc-f753e70ca0f3
617981fb-0111-4a21-81f7-85d9474d1a2d	d4d2fd14-5864-4ef3-907f-2aa08bfc5eb4
617981fb-0111-4a21-81f7-85d9474d1a2d	013bfe1a-1207-4a31-be98-fa5eac2a0983
617981fb-0111-4a21-81f7-85d9474d1a2d	c9d3ec48-9ce2-40e3-a866-0a783874dc90
617981fb-0111-4a21-81f7-85d9474d1a2d	af539303-a04f-496d-82f0-c6c2f5050a62
a053f70a-542c-4784-9e60-737ae5f8edb5	013bfe1a-1207-4a31-be98-fa5eac2a0983
ca123419-6d3a-4b19-b64f-43e2b99f24e6	af539303-a04f-496d-82f0-c6c2f5050a62
ca123419-6d3a-4b19-b64f-43e2b99f24e6	d4d2fd14-5864-4ef3-907f-2aa08bfc5eb4
e435fff0-1799-4855-95c6-7e13216cae6b	fce30348-1da5-4287-a5ab-50ba3f3e5b81
e435fff0-1799-4855-95c6-7e13216cae6b	65054880-79d1-453f-b115-9e79589dfea6
65054880-79d1-453f-b115-9e79589dfea6	9ff75cd3-8fba-4ef7-b502-db65e7341062
e5c9274c-55a4-4428-b4ab-387c6ee8cfb5	98d46a22-4870-404f-808a-4d601066115e
617981fb-0111-4a21-81f7-85d9474d1a2d	69a6ca70-1dc5-4c68-9074-247cb5e12b5e
e435fff0-1799-4855-95c6-7e13216cae6b	7538809e-9165-4753-bb76-8968bacfa374
e435fff0-1799-4855-95c6-7e13216cae6b	9eab38b2-0714-4481-9cdf-8f69124422e4
617981fb-0111-4a21-81f7-85d9474d1a2d	2f97a10b-f583-464c-a411-98aa393e4b7a
617981fb-0111-4a21-81f7-85d9474d1a2d	9236c4f8-b43e-4a62-8884-a7d4edca80fc
617981fb-0111-4a21-81f7-85d9474d1a2d	97a06a03-91cd-42f2-ab7a-98413a43a95d
617981fb-0111-4a21-81f7-85d9474d1a2d	1531b637-e05c-41ba-8330-6eb63098462d
617981fb-0111-4a21-81f7-85d9474d1a2d	ffb6f18d-1fe3-4c52-ae7d-daffc618c73c
617981fb-0111-4a21-81f7-85d9474d1a2d	ace72609-bcc8-4a5d-a087-1ebcad80e1ad
617981fb-0111-4a21-81f7-85d9474d1a2d	2bc0a4cb-4dfa-4e5c-b529-a4813cb409c4
617981fb-0111-4a21-81f7-85d9474d1a2d	b5835510-eb31-45d0-95a7-9a6304e8c4e8
617981fb-0111-4a21-81f7-85d9474d1a2d	3f58b0fb-e112-49b7-9234-c7d8cc858f0b
617981fb-0111-4a21-81f7-85d9474d1a2d	7a3d5de2-bf45-49b3-9895-17c1f49021ae
617981fb-0111-4a21-81f7-85d9474d1a2d	bdf61488-83d4-4827-b29c-76c7742f4ae8
617981fb-0111-4a21-81f7-85d9474d1a2d	208cd93f-5203-4317-aadd-01c04fdbb3cf
617981fb-0111-4a21-81f7-85d9474d1a2d	c041354d-8bda-465e-93af-cafab43337e4
617981fb-0111-4a21-81f7-85d9474d1a2d	6324675f-72a2-4c43-b07c-96065f63ca6e
617981fb-0111-4a21-81f7-85d9474d1a2d	00974d45-b847-4e7c-bf04-a3e6700eaa15
617981fb-0111-4a21-81f7-85d9474d1a2d	33bb94d4-a7c3-40f2-9607-2d1204d99268
617981fb-0111-4a21-81f7-85d9474d1a2d	ea48937f-7aaa-4650-a5f7-323c950737ee
1531b637-e05c-41ba-8330-6eb63098462d	00974d45-b847-4e7c-bf04-a3e6700eaa15
97a06a03-91cd-42f2-ab7a-98413a43a95d	ea48937f-7aaa-4650-a5f7-323c950737ee
97a06a03-91cd-42f2-ab7a-98413a43a95d	6324675f-72a2-4c43-b07c-96065f63ca6e
f840319e-f887-4327-8b6e-cb88bccaf44b	db42c8ed-1c71-4c23-b89a-b7b2773cb0b8
f840319e-f887-4327-8b6e-cb88bccaf44b	c5a17dee-7cad-421d-8855-c7782bd1b102
f840319e-f887-4327-8b6e-cb88bccaf44b	142afab5-1d19-4ccb-82e3-4cd2d316f9aa
f840319e-f887-4327-8b6e-cb88bccaf44b	28ef59ed-5539-434c-a62d-5f5638664b44
f840319e-f887-4327-8b6e-cb88bccaf44b	1ee268cf-2f40-4660-9765-eb5e7e377961
f840319e-f887-4327-8b6e-cb88bccaf44b	a739190b-2b25-4d87-ac0d-27d49d529d15
f840319e-f887-4327-8b6e-cb88bccaf44b	efcfb99c-172c-4796-876c-68d161f69093
f840319e-f887-4327-8b6e-cb88bccaf44b	8932a2e2-b7ae-4769-8cbd-bf989ba6673b
f840319e-f887-4327-8b6e-cb88bccaf44b	7265390b-838a-4b5d-8977-d6827b7e1e96
f840319e-f887-4327-8b6e-cb88bccaf44b	edd701cc-50d8-4b57-ba4a-e712e178b5b2
f840319e-f887-4327-8b6e-cb88bccaf44b	d42d77d6-d422-438f-9842-3c3ba468bcf7
f840319e-f887-4327-8b6e-cb88bccaf44b	95eb4f4e-7044-4c73-a409-18593db44e91
f840319e-f887-4327-8b6e-cb88bccaf44b	3dcc9f54-3ead-4751-ae7e-1d32e56af58f
f840319e-f887-4327-8b6e-cb88bccaf44b	024b2c05-277b-47d6-a82e-81f8cfb617fb
f840319e-f887-4327-8b6e-cb88bccaf44b	e5e26d94-c41e-4998-9eb3-a6203d57186d
f840319e-f887-4327-8b6e-cb88bccaf44b	fa4d716e-6b14-49ef-a227-c157d4637d62
f840319e-f887-4327-8b6e-cb88bccaf44b	2eca9dcb-86b4-4c7a-adbb-585aade2c725
142afab5-1d19-4ccb-82e3-4cd2d316f9aa	024b2c05-277b-47d6-a82e-81f8cfb617fb
142afab5-1d19-4ccb-82e3-4cd2d316f9aa	2eca9dcb-86b4-4c7a-adbb-585aade2c725
28ef59ed-5539-434c-a62d-5f5638664b44	e5e26d94-c41e-4998-9eb3-a6203d57186d
e8eb2cf0-e9ff-4e80-ae1f-3dca2cd64a9c	25d6b3dd-97d2-4727-af9c-0624f1ac3941
e8eb2cf0-e9ff-4e80-ae1f-3dca2cd64a9c	c759a209-0098-4865-a3cc-7415fe3ba038
c759a209-0098-4865-a3cc-7415fe3ba038	7ef2a2ed-687e-4e39-a62b-900b5289b95f
87d783d1-0c90-44eb-8071-3d638494e943	5fd63e3e-a5a2-4f0f-9399-a3f3df4c654c
617981fb-0111-4a21-81f7-85d9474d1a2d	a8601155-8088-41ad-a7a0-40e4804ca29a
f840319e-f887-4327-8b6e-cb88bccaf44b	1ae51603-6b8a-4c6a-8b34-c8a70e8f2aed
e8eb2cf0-e9ff-4e80-ae1f-3dca2cd64a9c	7d88dd7c-45f1-4d3e-85e6-3e262c6b726f
e8eb2cf0-e9ff-4e80-ae1f-3dca2cd64a9c	c4252ac9-3bc6-4413-8d73-3411a0d803a8
\.


--
-- Data for Name: credential; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.credential (id, salt, type, user_id, created_date, user_label, secret_data, credential_data, priority) FROM stdin;
a8cec6f0-78ec-41f9-aa5a-147a748da2a9	\N	password	733a0f8d-e2ac-4ef7-bfa4-0a017f3e73b1	1661337657240	\N	{"value":"2sGZ2FUsN2ldXiurOZC/V0tSSPgxVNgZkirqya7PJd0jT6PWO8SvyZGX2BlqTZs08PHTJc0TOsx0oaSt9Z9bYw==","salt":"U0/oBdsY+RtjhL2Hi/sdGA==","additionalParameters":{}}	{"hashIterations":27500,"algorithm":"pbkdf2-sha256","additionalParameters":{}}	10
237774b2-7f24-4d10-9f73-4fb98968b68f	\N	password	215dbd9f-19e6-446b-ae84-226fc1942282	1661337866448	\N	{"value":"6fK6qUUEC7Mg0nBdZigvYFIE+iCmUoqaQGpLX+VVUuxHfufO+COvwY2Ct+Ursi+konDfd3BgsLt5pBSbSztlWw==","salt":"wo567abYEooTBMG3iuGI8A==","additionalParameters":{}}	{"hashIterations":27500,"algorithm":"pbkdf2-sha256","additionalParameters":{}}	10
\.


--
-- Data for Name: databasechangelog; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) FROM stdin;
1.0.0.Final-KEYCLOAK-5461	sthorger@redhat.com	META-INF/jpa-changelog-1.0.0.Final.xml	2022-08-24 10:40:52.460752	1	EXECUTED	8:bda77d94bf90182a1e30c24f1c155ec7	createTable tableName=APPLICATION_DEFAULT_ROLES; createTable tableName=CLIENT; createTable tableName=CLIENT_SESSION; createTable tableName=CLIENT_SESSION_ROLE; createTable tableName=COMPOSITE_ROLE; createTable tableName=CREDENTIAL; createTable tab...		\N	4.8.0	\N	\N	1337652100
1.0.0.Final-KEYCLOAK-5461	sthorger@redhat.com	META-INF/db2-jpa-changelog-1.0.0.Final.xml	2022-08-24 10:40:52.468194	2	MARK_RAN	8:1ecb330f30986693d1cba9ab579fa219	createTable tableName=APPLICATION_DEFAULT_ROLES; createTable tableName=CLIENT; createTable tableName=CLIENT_SESSION; createTable tableName=CLIENT_SESSION_ROLE; createTable tableName=COMPOSITE_ROLE; createTable tableName=CREDENTIAL; createTable tab...		\N	4.8.0	\N	\N	1337652100
1.1.0.Beta1	sthorger@redhat.com	META-INF/jpa-changelog-1.1.0.Beta1.xml	2022-08-24 10:40:52.51698	3	EXECUTED	8:cb7ace19bc6d959f305605d255d4c843	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=CLIENT_ATTRIBUTES; createTable tableName=CLIENT_SESSION_NOTE; createTable tableName=APP_NODE_REGISTRATIONS; addColumn table...		\N	4.8.0	\N	\N	1337652100
1.1.0.Final	sthorger@redhat.com	META-INF/jpa-changelog-1.1.0.Final.xml	2022-08-24 10:40:52.523847	4	EXECUTED	8:80230013e961310e6872e871be424a63	renameColumn newColumnName=EVENT_TIME, oldColumnName=TIME, tableName=EVENT_ENTITY		\N	4.8.0	\N	\N	1337652100
1.2.0.Beta1	psilva@redhat.com	META-INF/jpa-changelog-1.2.0.Beta1.xml	2022-08-24 10:40:52.641306	5	EXECUTED	8:67f4c20929126adc0c8e9bf48279d244	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=PROTOCOL_MAPPER; createTable tableName=PROTOCOL_MAPPER_CONFIG; createTable tableName=...		\N	4.8.0	\N	\N	1337652100
1.2.0.Beta1	psilva@redhat.com	META-INF/db2-jpa-changelog-1.2.0.Beta1.xml	2022-08-24 10:40:52.645099	6	MARK_RAN	8:7311018b0b8179ce14628ab412bb6783	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=PROTOCOL_MAPPER; createTable tableName=PROTOCOL_MAPPER_CONFIG; createTable tableName=...		\N	4.8.0	\N	\N	1337652100
1.2.0.RC1	bburke@redhat.com	META-INF/jpa-changelog-1.2.0.CR1.xml	2022-08-24 10:40:52.759751	7	EXECUTED	8:037ba1216c3640f8785ee6b8e7c8e3c1	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=MIGRATION_MODEL; createTable tableName=IDENTITY_P...		\N	4.8.0	\N	\N	1337652100
1.2.0.RC1	bburke@redhat.com	META-INF/db2-jpa-changelog-1.2.0.CR1.xml	2022-08-24 10:40:52.76308	8	MARK_RAN	8:7fe6ffe4af4df289b3157de32c624263	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=MIGRATION_MODEL; createTable tableName=IDENTITY_P...		\N	4.8.0	\N	\N	1337652100
1.2.0.Final	keycloak	META-INF/jpa-changelog-1.2.0.Final.xml	2022-08-24 10:40:52.770351	9	EXECUTED	8:9c136bc3187083a98745c7d03bc8a303	update tableName=CLIENT; update tableName=CLIENT; update tableName=CLIENT		\N	4.8.0	\N	\N	1337652100
1.3.0	bburke@redhat.com	META-INF/jpa-changelog-1.3.0.xml	2022-08-24 10:40:52.890619	10	EXECUTED	8:b5f09474dca81fb56a97cf5b6553d331	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=ADMI...		\N	4.8.0	\N	\N	1337652100
1.4.0	bburke@redhat.com	META-INF/jpa-changelog-1.4.0.xml	2022-08-24 10:40:52.971998	11	EXECUTED	8:ca924f31bd2a3b219fdcfe78c82dacf4	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	4.8.0	\N	\N	1337652100
1.4.0	bburke@redhat.com	META-INF/db2-jpa-changelog-1.4.0.xml	2022-08-24 10:40:52.975045	12	MARK_RAN	8:8acad7483e106416bcfa6f3b824a16cd	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	4.8.0	\N	\N	1337652100
1.5.0	bburke@redhat.com	META-INF/jpa-changelog-1.5.0.xml	2022-08-24 10:40:53.040919	13	EXECUTED	8:9b1266d17f4f87c78226f5055408fd5e	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	4.8.0	\N	\N	1337652100
1.6.1_from15	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2022-08-24 10:40:53.071179	14	EXECUTED	8:d80ec4ab6dbfe573550ff72396c7e910	addColumn tableName=REALM; addColumn tableName=KEYCLOAK_ROLE; addColumn tableName=CLIENT; createTable tableName=OFFLINE_USER_SESSION; createTable tableName=OFFLINE_CLIENT_SESSION; addPrimaryKey constraintName=CONSTRAINT_OFFL_US_SES_PK2, tableName=...		\N	4.8.0	\N	\N	1337652100
1.6.1_from16-pre	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2022-08-24 10:40:53.07474	15	MARK_RAN	8:d86eb172171e7c20b9c849b584d147b2	delete tableName=OFFLINE_CLIENT_SESSION; delete tableName=OFFLINE_USER_SESSION		\N	4.8.0	\N	\N	1337652100
1.6.1_from16	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2022-08-24 10:40:53.077695	16	MARK_RAN	8:5735f46f0fa60689deb0ecdc2a0dea22	dropPrimaryKey constraintName=CONSTRAINT_OFFLINE_US_SES_PK, tableName=OFFLINE_USER_SESSION; dropPrimaryKey constraintName=CONSTRAINT_OFFLINE_CL_SES_PK, tableName=OFFLINE_CLIENT_SESSION; addColumn tableName=OFFLINE_USER_SESSION; update tableName=OF...		\N	4.8.0	\N	\N	1337652100
1.6.1	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2022-08-24 10:40:53.08014	17	EXECUTED	8:d41d8cd98f00b204e9800998ecf8427e	empty		\N	4.8.0	\N	\N	1337652100
1.7.0	bburke@redhat.com	META-INF/jpa-changelog-1.7.0.xml	2022-08-24 10:40:53.146406	18	EXECUTED	8:5c1a8fd2014ac7fc43b90a700f117b23	createTable tableName=KEYCLOAK_GROUP; createTable tableName=GROUP_ROLE_MAPPING; createTable tableName=GROUP_ATTRIBUTE; createTable tableName=USER_GROUP_MEMBERSHIP; createTable tableName=REALM_DEFAULT_GROUPS; addColumn tableName=IDENTITY_PROVIDER; ...		\N	4.8.0	\N	\N	1337652100
1.8.0	mposolda@redhat.com	META-INF/jpa-changelog-1.8.0.xml	2022-08-24 10:40:53.197633	19	EXECUTED	8:1f6c2c2dfc362aff4ed75b3f0ef6b331	addColumn tableName=IDENTITY_PROVIDER; createTable tableName=CLIENT_TEMPLATE; createTable tableName=CLIENT_TEMPLATE_ATTRIBUTES; createTable tableName=TEMPLATE_SCOPE_MAPPING; dropNotNullConstraint columnName=CLIENT_ID, tableName=PROTOCOL_MAPPER; ad...		\N	4.8.0	\N	\N	1337652100
1.8.0-2	keycloak	META-INF/jpa-changelog-1.8.0.xml	2022-08-24 10:40:53.203939	20	EXECUTED	8:dee9246280915712591f83a127665107	dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; update tableName=CREDENTIAL		\N	4.8.0	\N	\N	1337652100
authz-3.4.0.CR1-resource-server-pk-change-part1	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2022-08-24 10:40:53.673945	45	EXECUTED	8:a164ae073c56ffdbc98a615493609a52	addColumn tableName=RESOURCE_SERVER_POLICY; addColumn tableName=RESOURCE_SERVER_RESOURCE; addColumn tableName=RESOURCE_SERVER_SCOPE		\N	4.8.0	\N	\N	1337652100
1.8.0	mposolda@redhat.com	META-INF/db2-jpa-changelog-1.8.0.xml	2022-08-24 10:40:53.206891	21	MARK_RAN	8:9eb2ee1fa8ad1c5e426421a6f8fdfa6a	addColumn tableName=IDENTITY_PROVIDER; createTable tableName=CLIENT_TEMPLATE; createTable tableName=CLIENT_TEMPLATE_ATTRIBUTES; createTable tableName=TEMPLATE_SCOPE_MAPPING; dropNotNullConstraint columnName=CLIENT_ID, tableName=PROTOCOL_MAPPER; ad...		\N	4.8.0	\N	\N	1337652100
1.8.0-2	keycloak	META-INF/db2-jpa-changelog-1.8.0.xml	2022-08-24 10:40:53.209683	22	MARK_RAN	8:dee9246280915712591f83a127665107	dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; update tableName=CREDENTIAL		\N	4.8.0	\N	\N	1337652100
1.9.0	mposolda@redhat.com	META-INF/jpa-changelog-1.9.0.xml	2022-08-24 10:40:53.242447	23	EXECUTED	8:d9fa18ffa355320395b86270680dd4fe	update tableName=REALM; update tableName=REALM; update tableName=REALM; update tableName=REALM; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=REALM; update tableName=REALM; customChange; dr...		\N	4.8.0	\N	\N	1337652100
1.9.1	keycloak	META-INF/jpa-changelog-1.9.1.xml	2022-08-24 10:40:53.249646	24	EXECUTED	8:90cff506fedb06141ffc1c71c4a1214c	modifyDataType columnName=PRIVATE_KEY, tableName=REALM; modifyDataType columnName=PUBLIC_KEY, tableName=REALM; modifyDataType columnName=CERTIFICATE, tableName=REALM		\N	4.8.0	\N	\N	1337652100
1.9.1	keycloak	META-INF/db2-jpa-changelog-1.9.1.xml	2022-08-24 10:40:53.252691	25	MARK_RAN	8:11a788aed4961d6d29c427c063af828c	modifyDataType columnName=PRIVATE_KEY, tableName=REALM; modifyDataType columnName=CERTIFICATE, tableName=REALM		\N	4.8.0	\N	\N	1337652100
1.9.2	keycloak	META-INF/jpa-changelog-1.9.2.xml	2022-08-24 10:40:53.276298	26	EXECUTED	8:a4218e51e1faf380518cce2af5d39b43	createIndex indexName=IDX_USER_EMAIL, tableName=USER_ENTITY; createIndex indexName=IDX_USER_ROLE_MAPPING, tableName=USER_ROLE_MAPPING; createIndex indexName=IDX_USER_GROUP_MAPPING, tableName=USER_GROUP_MEMBERSHIP; createIndex indexName=IDX_USER_CO...		\N	4.8.0	\N	\N	1337652100
authz-2.0.0	psilva@redhat.com	META-INF/jpa-changelog-authz-2.0.0.xml	2022-08-24 10:40:53.343689	27	EXECUTED	8:d9e9a1bfaa644da9952456050f07bbdc	createTable tableName=RESOURCE_SERVER; addPrimaryKey constraintName=CONSTRAINT_FARS, tableName=RESOURCE_SERVER; addUniqueConstraint constraintName=UK_AU8TT6T700S9V50BU18WS5HA6, tableName=RESOURCE_SERVER; createTable tableName=RESOURCE_SERVER_RESOU...		\N	4.8.0	\N	\N	1337652100
authz-2.5.1	psilva@redhat.com	META-INF/jpa-changelog-authz-2.5.1.xml	2022-08-24 10:40:53.348738	28	EXECUTED	8:d1bf991a6163c0acbfe664b615314505	update tableName=RESOURCE_SERVER_POLICY		\N	4.8.0	\N	\N	1337652100
2.1.0-KEYCLOAK-5461	bburke@redhat.com	META-INF/jpa-changelog-2.1.0.xml	2022-08-24 10:40:53.40645	29	EXECUTED	8:88a743a1e87ec5e30bf603da68058a8c	createTable tableName=BROKER_LINK; createTable tableName=FED_USER_ATTRIBUTE; createTable tableName=FED_USER_CONSENT; createTable tableName=FED_USER_CONSENT_ROLE; createTable tableName=FED_USER_CONSENT_PROT_MAPPER; createTable tableName=FED_USER_CR...		\N	4.8.0	\N	\N	1337652100
2.2.0	bburke@redhat.com	META-INF/jpa-changelog-2.2.0.xml	2022-08-24 10:40:53.421262	30	EXECUTED	8:c5517863c875d325dea463d00ec26d7a	addColumn tableName=ADMIN_EVENT_ENTITY; createTable tableName=CREDENTIAL_ATTRIBUTE; createTable tableName=FED_CREDENTIAL_ATTRIBUTE; modifyDataType columnName=VALUE, tableName=CREDENTIAL; addForeignKeyConstraint baseTableName=FED_CREDENTIAL_ATTRIBU...		\N	4.8.0	\N	\N	1337652100
2.3.0	bburke@redhat.com	META-INF/jpa-changelog-2.3.0.xml	2022-08-24 10:40:53.444229	31	EXECUTED	8:ada8b4833b74a498f376d7136bc7d327	createTable tableName=FEDERATED_USER; addPrimaryKey constraintName=CONSTR_FEDERATED_USER, tableName=FEDERATED_USER; dropDefaultValue columnName=TOTP, tableName=USER_ENTITY; dropColumn columnName=TOTP, tableName=USER_ENTITY; addColumn tableName=IDE...		\N	4.8.0	\N	\N	1337652100
2.4.0	bburke@redhat.com	META-INF/jpa-changelog-2.4.0.xml	2022-08-24 10:40:53.450979	32	EXECUTED	8:b9b73c8ea7299457f99fcbb825c263ba	customChange		\N	4.8.0	\N	\N	1337652100
2.5.0	bburke@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2022-08-24 10:40:53.460382	33	EXECUTED	8:07724333e625ccfcfc5adc63d57314f3	customChange; modifyDataType columnName=USER_ID, tableName=OFFLINE_USER_SESSION		\N	4.8.0	\N	\N	1337652100
2.5.0-unicode-oracle	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2022-08-24 10:40:53.462982	34	MARK_RAN	8:8b6fd445958882efe55deb26fc541a7b	modifyDataType columnName=DESCRIPTION, tableName=AUTHENTICATION_FLOW; modifyDataType columnName=DESCRIPTION, tableName=CLIENT_TEMPLATE; modifyDataType columnName=DESCRIPTION, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=DESCRIPTION,...		\N	4.8.0	\N	\N	1337652100
2.5.0-unicode-other-dbs	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2022-08-24 10:40:53.500211	35	EXECUTED	8:29b29cfebfd12600897680147277a9d7	modifyDataType columnName=DESCRIPTION, tableName=AUTHENTICATION_FLOW; modifyDataType columnName=DESCRIPTION, tableName=CLIENT_TEMPLATE; modifyDataType columnName=DESCRIPTION, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=DESCRIPTION,...		\N	4.8.0	\N	\N	1337652100
2.5.0-duplicate-email-support	slawomir@dabek.name	META-INF/jpa-changelog-2.5.0.xml	2022-08-24 10:40:53.515235	36	EXECUTED	8:73ad77ca8fd0410c7f9f15a471fa52bc	addColumn tableName=REALM		\N	4.8.0	\N	\N	1337652100
2.5.0-unique-group-names	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2022-08-24 10:40:53.521216	37	EXECUTED	8:64f27a6fdcad57f6f9153210f2ec1bdb	addUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	4.8.0	\N	\N	1337652100
2.5.1	bburke@redhat.com	META-INF/jpa-changelog-2.5.1.xml	2022-08-24 10:40:53.527484	38	EXECUTED	8:27180251182e6c31846c2ddab4bc5781	addColumn tableName=FED_USER_CONSENT		\N	4.8.0	\N	\N	1337652100
3.0.0	bburke@redhat.com	META-INF/jpa-changelog-3.0.0.xml	2022-08-24 10:40:53.536096	39	EXECUTED	8:d56f201bfcfa7a1413eb3e9bc02978f9	addColumn tableName=IDENTITY_PROVIDER		\N	4.8.0	\N	\N	1337652100
3.2.0-fix	keycloak	META-INF/jpa-changelog-3.2.0.xml	2022-08-24 10:40:53.538881	40	MARK_RAN	8:91f5522bf6afdc2077dfab57fbd3455c	addNotNullConstraint columnName=REALM_ID, tableName=CLIENT_INITIAL_ACCESS		\N	4.8.0	\N	\N	1337652100
3.2.0-fix-with-keycloak-5416	keycloak	META-INF/jpa-changelog-3.2.0.xml	2022-08-24 10:40:53.541701	41	MARK_RAN	8:0f01b554f256c22caeb7d8aee3a1cdc8	dropIndex indexName=IDX_CLIENT_INIT_ACC_REALM, tableName=CLIENT_INITIAL_ACCESS; addNotNullConstraint columnName=REALM_ID, tableName=CLIENT_INITIAL_ACCESS; createIndex indexName=IDX_CLIENT_INIT_ACC_REALM, tableName=CLIENT_INITIAL_ACCESS		\N	4.8.0	\N	\N	1337652100
3.2.0-fix-offline-sessions	hmlnarik	META-INF/jpa-changelog-3.2.0.xml	2022-08-24 10:40:53.548344	42	EXECUTED	8:ab91cf9cee415867ade0e2df9651a947	customChange		\N	4.8.0	\N	\N	1337652100
3.2.0-fixed	keycloak	META-INF/jpa-changelog-3.2.0.xml	2022-08-24 10:40:53.657995	43	EXECUTED	8:ceac9b1889e97d602caf373eadb0d4b7	addColumn tableName=REALM; dropPrimaryKey constraintName=CONSTRAINT_OFFL_CL_SES_PK2, tableName=OFFLINE_CLIENT_SESSION; dropColumn columnName=CLIENT_SESSION_ID, tableName=OFFLINE_CLIENT_SESSION; addPrimaryKey constraintName=CONSTRAINT_OFFL_CL_SES_P...		\N	4.8.0	\N	\N	1337652100
3.3.0	keycloak	META-INF/jpa-changelog-3.3.0.xml	2022-08-24 10:40:53.667599	44	EXECUTED	8:84b986e628fe8f7fd8fd3c275c5259f2	addColumn tableName=USER_ENTITY		\N	4.8.0	\N	\N	1337652100
authz-3.4.0.CR1-resource-server-pk-change-part2-KEYCLOAK-6095	hmlnarik@redhat.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2022-08-24 10:40:53.680674	46	EXECUTED	8:70a2b4f1f4bd4dbf487114bdb1810e64	customChange		\N	4.8.0	\N	\N	1337652100
authz-3.4.0.CR1-resource-server-pk-change-part3-fixed	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2022-08-24 10:40:53.683304	47	MARK_RAN	8:7be68b71d2f5b94b8df2e824f2860fa2	dropIndex indexName=IDX_RES_SERV_POL_RES_SERV, tableName=RESOURCE_SERVER_POLICY; dropIndex indexName=IDX_RES_SRV_RES_RES_SRV, tableName=RESOURCE_SERVER_RESOURCE; dropIndex indexName=IDX_RES_SRV_SCOPE_RES_SRV, tableName=RESOURCE_SERVER_SCOPE		\N	4.8.0	\N	\N	1337652100
authz-3.4.0.CR1-resource-server-pk-change-part3-fixed-nodropindex	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2022-08-24 10:40:53.733494	48	EXECUTED	8:bab7c631093c3861d6cf6144cd944982	addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, tableName=RESOURCE_SERVER_POLICY; addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, tableName=RESOURCE_SERVER_RESOURCE; addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, ...		\N	4.8.0	\N	\N	1337652100
authn-3.4.0.CR1-refresh-token-max-reuse	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2022-08-24 10:40:53.744676	49	EXECUTED	8:fa809ac11877d74d76fe40869916daad	addColumn tableName=REALM		\N	4.8.0	\N	\N	1337652100
3.4.0	keycloak	META-INF/jpa-changelog-3.4.0.xml	2022-08-24 10:40:53.782434	50	EXECUTED	8:fac23540a40208f5f5e326f6ceb4d291	addPrimaryKey constraintName=CONSTRAINT_REALM_DEFAULT_ROLES, tableName=REALM_DEFAULT_ROLES; addPrimaryKey constraintName=CONSTRAINT_COMPOSITE_ROLE, tableName=COMPOSITE_ROLE; addPrimaryKey constraintName=CONSTR_REALM_DEFAULT_GROUPS, tableName=REALM...		\N	4.8.0	\N	\N	1337652100
3.4.0-KEYCLOAK-5230	hmlnarik@redhat.com	META-INF/jpa-changelog-3.4.0.xml	2022-08-24 10:40:53.807928	51	EXECUTED	8:2612d1b8a97e2b5588c346e817307593	createIndex indexName=IDX_FU_ATTRIBUTE, tableName=FED_USER_ATTRIBUTE; createIndex indexName=IDX_FU_CONSENT, tableName=FED_USER_CONSENT; createIndex indexName=IDX_FU_CONSENT_RU, tableName=FED_USER_CONSENT; createIndex indexName=IDX_FU_CREDENTIAL, t...		\N	4.8.0	\N	\N	1337652100
3.4.1	psilva@redhat.com	META-INF/jpa-changelog-3.4.1.xml	2022-08-24 10:40:53.813175	52	EXECUTED	8:9842f155c5db2206c88bcb5d1046e941	modifyDataType columnName=VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.8.0	\N	\N	1337652100
3.4.2	keycloak	META-INF/jpa-changelog-3.4.2.xml	2022-08-24 10:40:53.817306	53	EXECUTED	8:2e12e06e45498406db72d5b3da5bbc76	update tableName=REALM		\N	4.8.0	\N	\N	1337652100
3.4.2-KEYCLOAK-5172	mkanis@redhat.com	META-INF/jpa-changelog-3.4.2.xml	2022-08-24 10:40:53.821786	54	EXECUTED	8:33560e7c7989250c40da3abdabdc75a4	update tableName=CLIENT		\N	4.8.0	\N	\N	1337652100
4.0.0-KEYCLOAK-6335	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2022-08-24 10:40:53.828636	55	EXECUTED	8:87a8d8542046817a9107c7eb9cbad1cd	createTable tableName=CLIENT_AUTH_FLOW_BINDINGS; addPrimaryKey constraintName=C_CLI_FLOW_BIND, tableName=CLIENT_AUTH_FLOW_BINDINGS		\N	4.8.0	\N	\N	1337652100
4.0.0-CLEANUP-UNUSED-TABLE	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2022-08-24 10:40:53.834102	56	EXECUTED	8:3ea08490a70215ed0088c273d776311e	dropTable tableName=CLIENT_IDENTITY_PROV_MAPPING		\N	4.8.0	\N	\N	1337652100
4.0.0-KEYCLOAK-6228	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2022-08-24 10:40:53.870198	57	EXECUTED	8:2d56697c8723d4592ab608ce14b6ed68	dropUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHOGM8UEWRT, tableName=USER_CONSENT; dropNotNullConstraint columnName=CLIENT_ID, tableName=USER_CONSENT; addColumn tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHO...		\N	4.8.0	\N	\N	1337652100
4.0.0-KEYCLOAK-5579-fixed	mposolda@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2022-08-24 10:40:53.999072	58	EXECUTED	8:3e423e249f6068ea2bbe48bf907f9d86	dropForeignKeyConstraint baseTableName=CLIENT_TEMPLATE_ATTRIBUTES, constraintName=FK_CL_TEMPL_ATTR_TEMPL; renameTable newTableName=CLIENT_SCOPE_ATTRIBUTES, oldTableName=CLIENT_TEMPLATE_ATTRIBUTES; renameColumn newColumnName=SCOPE_ID, oldColumnName...		\N	4.8.0	\N	\N	1337652100
authz-4.0.0.CR1	psilva@redhat.com	META-INF/jpa-changelog-authz-4.0.0.CR1.xml	2022-08-24 10:40:54.037294	59	EXECUTED	8:15cabee5e5df0ff099510a0fc03e4103	createTable tableName=RESOURCE_SERVER_PERM_TICKET; addPrimaryKey constraintName=CONSTRAINT_FAPMT, tableName=RESOURCE_SERVER_PERM_TICKET; addForeignKeyConstraint baseTableName=RESOURCE_SERVER_PERM_TICKET, constraintName=FK_FRSRHO213XCX4WNKOG82SSPMT...		\N	4.8.0	\N	\N	1337652100
authz-4.0.0.Beta3	psilva@redhat.com	META-INF/jpa-changelog-authz-4.0.0.Beta3.xml	2022-08-24 10:40:54.045626	60	EXECUTED	8:4b80200af916ac54d2ffbfc47918ab0e	addColumn tableName=RESOURCE_SERVER_POLICY; addColumn tableName=RESOURCE_SERVER_PERM_TICKET; addForeignKeyConstraint baseTableName=RESOURCE_SERVER_PERM_TICKET, constraintName=FK_FRSRPO2128CX4WNKOG82SSRFY, referencedTableName=RESOURCE_SERVER_POLICY		\N	4.8.0	\N	\N	1337652100
authz-4.2.0.Final	mhajas@redhat.com	META-INF/jpa-changelog-authz-4.2.0.Final.xml	2022-08-24 10:40:54.056658	61	EXECUTED	8:66564cd5e168045d52252c5027485bbb	createTable tableName=RESOURCE_URIS; addForeignKeyConstraint baseTableName=RESOURCE_URIS, constraintName=FK_RESOURCE_SERVER_URIS, referencedTableName=RESOURCE_SERVER_RESOURCE; customChange; dropColumn columnName=URI, tableName=RESOURCE_SERVER_RESO...		\N	4.8.0	\N	\N	1337652100
authz-4.2.0.Final-KEYCLOAK-9944	hmlnarik@redhat.com	META-INF/jpa-changelog-authz-4.2.0.Final.xml	2022-08-24 10:40:54.062806	62	EXECUTED	8:1c7064fafb030222be2bd16ccf690f6f	addPrimaryKey constraintName=CONSTRAINT_RESOUR_URIS_PK, tableName=RESOURCE_URIS		\N	4.8.0	\N	\N	1337652100
4.2.0-KEYCLOAK-6313	wadahiro@gmail.com	META-INF/jpa-changelog-4.2.0.xml	2022-08-24 10:40:54.068585	63	EXECUTED	8:2de18a0dce10cdda5c7e65c9b719b6e5	addColumn tableName=REQUIRED_ACTION_PROVIDER		\N	4.8.0	\N	\N	1337652100
4.3.0-KEYCLOAK-7984	wadahiro@gmail.com	META-INF/jpa-changelog-4.3.0.xml	2022-08-24 10:40:54.074378	64	EXECUTED	8:03e413dd182dcbd5c57e41c34d0ef682	update tableName=REQUIRED_ACTION_PROVIDER		\N	4.8.0	\N	\N	1337652100
4.6.0-KEYCLOAK-7950	psilva@redhat.com	META-INF/jpa-changelog-4.6.0.xml	2022-08-24 10:40:54.079274	65	EXECUTED	8:d27b42bb2571c18fbe3fe4e4fb7582a7	update tableName=RESOURCE_SERVER_RESOURCE		\N	4.8.0	\N	\N	1337652100
4.6.0-KEYCLOAK-8377	keycloak	META-INF/jpa-changelog-4.6.0.xml	2022-08-24 10:40:54.091413	66	EXECUTED	8:698baf84d9fd0027e9192717c2154fb8	createTable tableName=ROLE_ATTRIBUTE; addPrimaryKey constraintName=CONSTRAINT_ROLE_ATTRIBUTE_PK, tableName=ROLE_ATTRIBUTE; addForeignKeyConstraint baseTableName=ROLE_ATTRIBUTE, constraintName=FK_ROLE_ATTRIBUTE_ID, referencedTableName=KEYCLOAK_ROLE...		\N	4.8.0	\N	\N	1337652100
4.6.0-KEYCLOAK-8555	gideonray@gmail.com	META-INF/jpa-changelog-4.6.0.xml	2022-08-24 10:40:54.097603	67	EXECUTED	8:ced8822edf0f75ef26eb51582f9a821a	createIndex indexName=IDX_COMPONENT_PROVIDER_TYPE, tableName=COMPONENT		\N	4.8.0	\N	\N	1337652100
4.7.0-KEYCLOAK-1267	sguilhen@redhat.com	META-INF/jpa-changelog-4.7.0.xml	2022-08-24 10:40:54.113921	68	EXECUTED	8:f0abba004cf429e8afc43056df06487d	addColumn tableName=REALM		\N	4.8.0	\N	\N	1337652100
4.7.0-KEYCLOAK-7275	keycloak	META-INF/jpa-changelog-4.7.0.xml	2022-08-24 10:40:54.131012	69	EXECUTED	8:6662f8b0b611caa359fcf13bf63b4e24	renameColumn newColumnName=CREATED_ON, oldColumnName=LAST_SESSION_REFRESH, tableName=OFFLINE_USER_SESSION; addNotNullConstraint columnName=CREATED_ON, tableName=OFFLINE_USER_SESSION; addColumn tableName=OFFLINE_USER_SESSION; customChange; createIn...		\N	4.8.0	\N	\N	1337652100
4.8.0-KEYCLOAK-8835	sguilhen@redhat.com	META-INF/jpa-changelog-4.8.0.xml	2022-08-24 10:40:54.140132	70	EXECUTED	8:9e6b8009560f684250bdbdf97670d39e	addNotNullConstraint columnName=SSO_MAX_LIFESPAN_REMEMBER_ME, tableName=REALM; addNotNullConstraint columnName=SSO_IDLE_TIMEOUT_REMEMBER_ME, tableName=REALM		\N	4.8.0	\N	\N	1337652100
authz-7.0.0-KEYCLOAK-10443	psilva@redhat.com	META-INF/jpa-changelog-authz-7.0.0.xml	2022-08-24 10:40:54.146342	71	EXECUTED	8:4223f561f3b8dc655846562b57bb502e	addColumn tableName=RESOURCE_SERVER		\N	4.8.0	\N	\N	1337652100
8.0.0-adding-credential-columns	keycloak	META-INF/jpa-changelog-8.0.0.xml	2022-08-24 10:40:54.157177	72	EXECUTED	8:215a31c398b363ce383a2b301202f29e	addColumn tableName=CREDENTIAL; addColumn tableName=FED_USER_CREDENTIAL		\N	4.8.0	\N	\N	1337652100
8.0.0-updating-credential-data-not-oracle-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2022-08-24 10:40:54.167399	73	EXECUTED	8:83f7a671792ca98b3cbd3a1a34862d3d	update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL		\N	4.8.0	\N	\N	1337652100
8.0.0-updating-credential-data-oracle-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2022-08-24 10:40:54.169735	74	MARK_RAN	8:f58ad148698cf30707a6efbdf8061aa7	update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL		\N	4.8.0	\N	\N	1337652100
8.0.0-credential-cleanup-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2022-08-24 10:40:54.233279	75	EXECUTED	8:79e4fd6c6442980e58d52ffc3ee7b19c	dropDefaultValue columnName=COUNTER, tableName=CREDENTIAL; dropDefaultValue columnName=DIGITS, tableName=CREDENTIAL; dropDefaultValue columnName=PERIOD, tableName=CREDENTIAL; dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; dropColumn ...		\N	4.8.0	\N	\N	1337652100
8.0.0-resource-tag-support	keycloak	META-INF/jpa-changelog-8.0.0.xml	2022-08-24 10:40:54.305224	76	EXECUTED	8:87af6a1e6d241ca4b15801d1f86a297d	addColumn tableName=MIGRATION_MODEL; createIndex indexName=IDX_UPDATE_TIME, tableName=MIGRATION_MODEL		\N	4.8.0	\N	\N	1337652100
9.0.0-always-display-client	keycloak	META-INF/jpa-changelog-9.0.0.xml	2022-08-24 10:40:54.313048	77	EXECUTED	8:b44f8d9b7b6ea455305a6d72a200ed15	addColumn tableName=CLIENT		\N	4.8.0	\N	\N	1337652100
9.0.0-drop-constraints-for-column-increase	keycloak	META-INF/jpa-changelog-9.0.0.xml	2022-08-24 10:40:54.315438	78	MARK_RAN	8:2d8ed5aaaeffd0cb004c046b4a903ac5	dropUniqueConstraint constraintName=UK_FRSR6T700S9V50BU18WS5PMT, tableName=RESOURCE_SERVER_PERM_TICKET; dropUniqueConstraint constraintName=UK_FRSR6T700S9V50BU18WS5HA6, tableName=RESOURCE_SERVER_RESOURCE; dropPrimaryKey constraintName=CONSTRAINT_O...		\N	4.8.0	\N	\N	1337652100
9.0.0-increase-column-size-federated-fk	keycloak	META-INF/jpa-changelog-9.0.0.xml	2022-08-24 10:40:54.333202	79	EXECUTED	8:e290c01fcbc275326c511633f6e2acde	modifyDataType columnName=CLIENT_ID, tableName=FED_USER_CONSENT; modifyDataType columnName=CLIENT_REALM_CONSTRAINT, tableName=KEYCLOAK_ROLE; modifyDataType columnName=OWNER, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=CLIENT_ID, ta...		\N	4.8.0	\N	\N	1337652100
9.0.0-recreate-constraints-after-column-increase	keycloak	META-INF/jpa-changelog-9.0.0.xml	2022-08-24 10:40:54.335466	80	MARK_RAN	8:c9db8784c33cea210872ac2d805439f8	addNotNullConstraint columnName=CLIENT_ID, tableName=OFFLINE_CLIENT_SESSION; addNotNullConstraint columnName=OWNER, tableName=RESOURCE_SERVER_PERM_TICKET; addNotNullConstraint columnName=REQUESTER, tableName=RESOURCE_SERVER_PERM_TICKET; addNotNull...		\N	4.8.0	\N	\N	1337652100
9.0.1-add-index-to-client.client_id	keycloak	META-INF/jpa-changelog-9.0.1.xml	2022-08-24 10:40:54.342102	81	EXECUTED	8:95b676ce8fc546a1fcfb4c92fae4add5	createIndex indexName=IDX_CLIENT_ID, tableName=CLIENT		\N	4.8.0	\N	\N	1337652100
9.0.1-KEYCLOAK-12579-drop-constraints	keycloak	META-INF/jpa-changelog-9.0.1.xml	2022-08-24 10:40:54.34437	82	MARK_RAN	8:38a6b2a41f5651018b1aca93a41401e5	dropUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	4.8.0	\N	\N	1337652100
9.0.1-KEYCLOAK-12579-add-not-null-constraint	keycloak	META-INF/jpa-changelog-9.0.1.xml	2022-08-24 10:40:54.350724	83	EXECUTED	8:3fb99bcad86a0229783123ac52f7609c	addNotNullConstraint columnName=PARENT_GROUP, tableName=KEYCLOAK_GROUP		\N	4.8.0	\N	\N	1337652100
9.0.1-KEYCLOAK-12579-recreate-constraints	keycloak	META-INF/jpa-changelog-9.0.1.xml	2022-08-24 10:40:54.353299	84	MARK_RAN	8:64f27a6fdcad57f6f9153210f2ec1bdb	addUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	4.8.0	\N	\N	1337652100
9.0.1-add-index-to-events	keycloak	META-INF/jpa-changelog-9.0.1.xml	2022-08-24 10:40:54.358937	85	EXECUTED	8:ab4f863f39adafd4c862f7ec01890abc	createIndex indexName=IDX_EVENT_TIME, tableName=EVENT_ENTITY		\N	4.8.0	\N	\N	1337652100
map-remove-ri	keycloak	META-INF/jpa-changelog-11.0.0.xml	2022-08-24 10:40:54.365778	86	EXECUTED	8:13c419a0eb336e91ee3a3bf8fda6e2a7	dropForeignKeyConstraint baseTableName=REALM, constraintName=FK_TRAF444KK6QRKMS7N56AIWQ5Y; dropForeignKeyConstraint baseTableName=KEYCLOAK_ROLE, constraintName=FK_KJHO5LE2C0RAL09FL8CM9WFW9		\N	4.8.0	\N	\N	1337652100
map-remove-ri	keycloak	META-INF/jpa-changelog-12.0.0.xml	2022-08-24 10:40:54.376001	87	EXECUTED	8:e3fb1e698e0471487f51af1ed80fe3ac	dropForeignKeyConstraint baseTableName=REALM_DEFAULT_GROUPS, constraintName=FK_DEF_GROUPS_GROUP; dropForeignKeyConstraint baseTableName=REALM_DEFAULT_ROLES, constraintName=FK_H4WPD7W4HSOOLNI3H0SW7BTJE; dropForeignKeyConstraint baseTableName=CLIENT...		\N	4.8.0	\N	\N	1337652100
12.1.0-add-realm-localization-table	keycloak	META-INF/jpa-changelog-12.0.0.xml	2022-08-24 10:40:54.38465	88	EXECUTED	8:babadb686aab7b56562817e60bf0abd0	createTable tableName=REALM_LOCALIZATIONS; addPrimaryKey tableName=REALM_LOCALIZATIONS		\N	4.8.0	\N	\N	1337652100
default-roles	keycloak	META-INF/jpa-changelog-13.0.0.xml	2022-08-24 10:40:54.392478	89	EXECUTED	8:72d03345fda8e2f17093d08801947773	addColumn tableName=REALM; customChange		\N	4.8.0	\N	\N	1337652100
default-roles-cleanup	keycloak	META-INF/jpa-changelog-13.0.0.xml	2022-08-24 10:40:54.401181	90	EXECUTED	8:61c9233951bd96ffecd9ba75f7d978a4	dropTable tableName=REALM_DEFAULT_ROLES; dropTable tableName=CLIENT_DEFAULT_ROLES		\N	4.8.0	\N	\N	1337652100
13.0.0-KEYCLOAK-16844	keycloak	META-INF/jpa-changelog-13.0.0.xml	2022-08-24 10:40:54.408809	91	EXECUTED	8:ea82e6ad945cec250af6372767b25525	createIndex indexName=IDX_OFFLINE_USS_PRELOAD, tableName=OFFLINE_USER_SESSION		\N	4.8.0	\N	\N	1337652100
map-remove-ri-13.0.0	keycloak	META-INF/jpa-changelog-13.0.0.xml	2022-08-24 10:40:54.421644	92	EXECUTED	8:d3f4a33f41d960ddacd7e2ef30d126b3	dropForeignKeyConstraint baseTableName=DEFAULT_CLIENT_SCOPE, constraintName=FK_R_DEF_CLI_SCOPE_SCOPE; dropForeignKeyConstraint baseTableName=CLIENT_SCOPE_CLIENT, constraintName=FK_C_CLI_SCOPE_SCOPE; dropForeignKeyConstraint baseTableName=CLIENT_SC...		\N	4.8.0	\N	\N	1337652100
13.0.0-KEYCLOAK-17992-drop-constraints	keycloak	META-INF/jpa-changelog-13.0.0.xml	2022-08-24 10:40:54.423994	93	MARK_RAN	8:1284a27fbd049d65831cb6fc07c8a783	dropPrimaryKey constraintName=C_CLI_SCOPE_BIND, tableName=CLIENT_SCOPE_CLIENT; dropIndex indexName=IDX_CLSCOPE_CL, tableName=CLIENT_SCOPE_CLIENT; dropIndex indexName=IDX_CL_CLSCOPE, tableName=CLIENT_SCOPE_CLIENT		\N	4.8.0	\N	\N	1337652100
13.0.0-increase-column-size-federated	keycloak	META-INF/jpa-changelog-13.0.0.xml	2022-08-24 10:40:54.433695	94	EXECUTED	8:9d11b619db2ae27c25853b8a37cd0dea	modifyDataType columnName=CLIENT_ID, tableName=CLIENT_SCOPE_CLIENT; modifyDataType columnName=SCOPE_ID, tableName=CLIENT_SCOPE_CLIENT		\N	4.8.0	\N	\N	1337652100
13.0.0-KEYCLOAK-17992-recreate-constraints	keycloak	META-INF/jpa-changelog-13.0.0.xml	2022-08-24 10:40:54.435955	95	MARK_RAN	8:3002bb3997451bb9e8bac5c5cd8d6327	addNotNullConstraint columnName=CLIENT_ID, tableName=CLIENT_SCOPE_CLIENT; addNotNullConstraint columnName=SCOPE_ID, tableName=CLIENT_SCOPE_CLIENT; addPrimaryKey constraintName=C_CLI_SCOPE_BIND, tableName=CLIENT_SCOPE_CLIENT; createIndex indexName=...		\N	4.8.0	\N	\N	1337652100
json-string-accomodation-fixed	keycloak	META-INF/jpa-changelog-13.0.0.xml	2022-08-24 10:40:54.445406	96	EXECUTED	8:dfbee0d6237a23ef4ccbb7a4e063c163	addColumn tableName=REALM_ATTRIBUTE; update tableName=REALM_ATTRIBUTE; dropColumn columnName=VALUE, tableName=REALM_ATTRIBUTE; renameColumn newColumnName=VALUE, oldColumnName=VALUE_NEW, tableName=REALM_ATTRIBUTE		\N	4.8.0	\N	\N	1337652100
14.0.0-KEYCLOAK-11019	keycloak	META-INF/jpa-changelog-14.0.0.xml	2022-08-24 10:40:54.456965	97	EXECUTED	8:75f3e372df18d38c62734eebb986b960	createIndex indexName=IDX_OFFLINE_CSS_PRELOAD, tableName=OFFLINE_CLIENT_SESSION; createIndex indexName=IDX_OFFLINE_USS_BY_USER, tableName=OFFLINE_USER_SESSION; createIndex indexName=IDX_OFFLINE_USS_BY_USERSESS, tableName=OFFLINE_USER_SESSION		\N	4.8.0	\N	\N	1337652100
14.0.0-KEYCLOAK-18286	keycloak	META-INF/jpa-changelog-14.0.0.xml	2022-08-24 10:40:54.459585	98	MARK_RAN	8:7fee73eddf84a6035691512c85637eef	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.8.0	\N	\N	1337652100
14.0.0-KEYCLOAK-18286-revert	keycloak	META-INF/jpa-changelog-14.0.0.xml	2022-08-24 10:40:54.469889	99	MARK_RAN	8:7a11134ab12820f999fbf3bb13c3adc8	dropIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.8.0	\N	\N	1337652100
14.0.0-KEYCLOAK-18286-supported-dbs	keycloak	META-INF/jpa-changelog-14.0.0.xml	2022-08-24 10:40:54.47667	100	EXECUTED	8:c0f6eaac1f3be773ffe54cb5b8482b70	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.8.0	\N	\N	1337652100
14.0.0-KEYCLOAK-18286-unsupported-dbs	keycloak	META-INF/jpa-changelog-14.0.0.xml	2022-08-24 10:40:54.479098	101	MARK_RAN	8:18186f0008b86e0f0f49b0c4d0e842ac	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.8.0	\N	\N	1337652100
KEYCLOAK-17267-add-index-to-user-attributes	keycloak	META-INF/jpa-changelog-14.0.0.xml	2022-08-24 10:40:54.484688	102	EXECUTED	8:09c2780bcb23b310a7019d217dc7b433	createIndex indexName=IDX_USER_ATTRIBUTE_NAME, tableName=USER_ATTRIBUTE		\N	4.8.0	\N	\N	1337652100
KEYCLOAK-18146-add-saml-art-binding-identifier	keycloak	META-INF/jpa-changelog-14.0.0.xml	2022-08-24 10:40:54.490679	103	EXECUTED	8:276a44955eab693c970a42880197fff2	customChange		\N	4.8.0	\N	\N	1337652100
15.0.0-KEYCLOAK-18467	keycloak	META-INF/jpa-changelog-15.0.0.xml	2022-08-24 10:40:54.501068	104	EXECUTED	8:ba8ee3b694d043f2bfc1a1079d0760d7	addColumn tableName=REALM_LOCALIZATIONS; update tableName=REALM_LOCALIZATIONS; dropColumn columnName=TEXTS, tableName=REALM_LOCALIZATIONS; renameColumn newColumnName=TEXTS, oldColumnName=TEXTS_NEW, tableName=REALM_LOCALIZATIONS; addNotNullConstrai...		\N	4.8.0	\N	\N	1337652100
17.0.0-9562	keycloak	META-INF/jpa-changelog-17.0.0.xml	2022-08-24 10:40:54.506966	105	EXECUTED	8:5e06b1d75f5d17685485e610c2851b17	createIndex indexName=IDX_USER_SERVICE_ACCOUNT, tableName=USER_ENTITY		\N	4.8.0	\N	\N	1337652100
18.0.0-10625-IDX_ADMIN_EVENT_TIME	keycloak	META-INF/jpa-changelog-18.0.0.xml	2022-08-24 10:40:54.512993	106	EXECUTED	8:4b80546c1dc550ac552ee7b24a4ab7c0	createIndex indexName=IDX_ADMIN_EVENT_TIME, tableName=ADMIN_EVENT_ENTITY		\N	4.8.0	\N	\N	1337652100
19.0.0-10135	keycloak	META-INF/jpa-changelog-19.0.0.xml	2022-08-24 10:40:54.518935	107	EXECUTED	8:af510cd1bb2ab6339c45372f3e491696	customChange		\N	4.8.0	\N	\N	1337652100
\.


--
-- Data for Name: databasechangeloglock; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.databasechangeloglock (id, locked, lockgranted, lockedby) FROM stdin;
1	f	\N	\N
1000	f	\N	\N
1001	f	\N	\N
\.


--
-- Data for Name: default_client_scope; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.default_client_scope (realm_id, scope_id, default_scope) FROM stdin;
d86ec37e-5c02-4219-bb0d-99cb545457ff	8f3ad643-c03d-4e51-8b7d-1505759ec264	f
d86ec37e-5c02-4219-bb0d-99cb545457ff	35336663-16ef-418f-a063-1cfd0363c77b	t
d86ec37e-5c02-4219-bb0d-99cb545457ff	d0004cee-7d50-4c70-98b0-c2ab20de8c24	t
d86ec37e-5c02-4219-bb0d-99cb545457ff	b0fc516e-9351-46b4-8c8d-08fdddfab057	t
d86ec37e-5c02-4219-bb0d-99cb545457ff	9cac0c30-60d3-436d-8444-00f046b7e5ca	f
d86ec37e-5c02-4219-bb0d-99cb545457ff	f013df01-3a46-4633-b587-79af1d435e3b	f
d86ec37e-5c02-4219-bb0d-99cb545457ff	b09bf549-596a-4034-9329-04375128a29f	t
d86ec37e-5c02-4219-bb0d-99cb545457ff	086d7bf5-cfff-4609-8aba-5461aea83734	t
d86ec37e-5c02-4219-bb0d-99cb545457ff	f1537516-3935-4b25-a382-71055478cbff	f
d86ec37e-5c02-4219-bb0d-99cb545457ff	db4509b6-791c-40e4-bba6-a85e67b9a25e	t
ba1a6f7d-badd-4ac5-9ce3-3a5dc0dd1d0b	eb81543f-1bb5-4bb9-84bd-217231dc6914	f
ba1a6f7d-badd-4ac5-9ce3-3a5dc0dd1d0b	54a89283-5d57-478d-bf78-c6b557b19f94	t
ba1a6f7d-badd-4ac5-9ce3-3a5dc0dd1d0b	8dcda776-69c3-41df-a9fe-82ad55a65537	t
ba1a6f7d-badd-4ac5-9ce3-3a5dc0dd1d0b	c11595f8-0c6a-4325-9610-cceb12f45a0e	t
ba1a6f7d-badd-4ac5-9ce3-3a5dc0dd1d0b	d56fa960-c2d6-48e9-ba20-dd229d6419d7	f
ba1a6f7d-badd-4ac5-9ce3-3a5dc0dd1d0b	65b8f3f8-bbac-4f62-91e0-583f4acd826a	f
ba1a6f7d-badd-4ac5-9ce3-3a5dc0dd1d0b	a261d167-16bd-4e94-8067-957670b876a0	t
ba1a6f7d-badd-4ac5-9ce3-3a5dc0dd1d0b	ebbd03b4-43c2-4d7d-80ab-4f62aeffd088	t
ba1a6f7d-badd-4ac5-9ce3-3a5dc0dd1d0b	0d56fbd7-1120-41df-96ec-760c3cd9f088	f
ba1a6f7d-badd-4ac5-9ce3-3a5dc0dd1d0b	53149023-1608-4a72-b605-a330acf727d1	t
\.


--
-- Data for Name: event_entity; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.event_entity (id, client_id, details_json, error, ip_address, realm_id, session_id, event_time, type, user_id) FROM stdin;
\.


--
-- Data for Name: fed_user_attribute; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.fed_user_attribute (id, name, user_id, realm_id, storage_provider_id, value) FROM stdin;
\.


--
-- Data for Name: fed_user_consent; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.fed_user_consent (id, client_id, user_id, realm_id, storage_provider_id, created_date, last_updated_date, client_storage_provider, external_client_id) FROM stdin;
\.


--
-- Data for Name: fed_user_consent_cl_scope; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.fed_user_consent_cl_scope (user_consent_id, scope_id) FROM stdin;
\.


--
-- Data for Name: fed_user_credential; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.fed_user_credential (id, salt, type, created_date, user_id, realm_id, storage_provider_id, user_label, secret_data, credential_data, priority) FROM stdin;
\.


--
-- Data for Name: fed_user_group_membership; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.fed_user_group_membership (group_id, user_id, realm_id, storage_provider_id) FROM stdin;
\.


--
-- Data for Name: fed_user_required_action; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.fed_user_required_action (required_action, user_id, realm_id, storage_provider_id) FROM stdin;
\.


--
-- Data for Name: fed_user_role_mapping; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.fed_user_role_mapping (role_id, user_id, realm_id, storage_provider_id) FROM stdin;
\.


--
-- Data for Name: federated_identity; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.federated_identity (identity_provider, realm_id, federated_user_id, federated_username, token, user_id) FROM stdin;
\.


--
-- Data for Name: federated_user; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.federated_user (id, storage_provider_id, realm_id) FROM stdin;
\.


--
-- Data for Name: group_attribute; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.group_attribute (id, name, value, group_id) FROM stdin;
56de0486-b8d3-40ed-bdb7-c4cdcf805900	group_attr	The Value	a3125c94-d207-4ca8-a0b9-160ca173792d
\.


--
-- Data for Name: group_role_mapping; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.group_role_mapping (role_id, group_id) FROM stdin;
5ebadddf-23f9-4b76-92a9-5e81d33077b6	a3125c94-d207-4ca8-a0b9-160ca173792d
\.


--
-- Data for Name: identity_provider; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.identity_provider (internal_id, enabled, provider_alias, provider_id, store_token, authenticate_by_default, realm_id, add_token_role, trust_email, first_broker_login_flow_id, post_broker_login_flow_id, provider_display_name, link_only) FROM stdin;
\.


--
-- Data for Name: identity_provider_config; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.identity_provider_config (identity_provider_id, value, name) FROM stdin;
\.


--
-- Data for Name: identity_provider_mapper; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.identity_provider_mapper (id, name, idp_alias, idp_mapper_name, realm_id) FROM stdin;
\.


--
-- Data for Name: idp_mapper_config; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.idp_mapper_config (idp_mapper_id, value, name) FROM stdin;
\.


--
-- Data for Name: keycloak_group; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.keycloak_group (id, name, parent_group, realm_id) FROM stdin;
a3125c94-d207-4ca8-a0b9-160ca173792d	a_group	 	ba1a6f7d-badd-4ac5-9ce3-3a5dc0dd1d0b
\.


--
-- Data for Name: keycloak_role; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) FROM stdin;
e435fff0-1799-4855-95c6-7e13216cae6b	d86ec37e-5c02-4219-bb0d-99cb545457ff	f	${role_default-roles}	default-roles-master	d86ec37e-5c02-4219-bb0d-99cb545457ff	\N	\N
5444d1e9-d828-4e71-81a4-8f70884f1bc7	d86ec37e-5c02-4219-bb0d-99cb545457ff	f	${role_create-realm}	create-realm	d86ec37e-5c02-4219-bb0d-99cb545457ff	\N	\N
617981fb-0111-4a21-81f7-85d9474d1a2d	d86ec37e-5c02-4219-bb0d-99cb545457ff	f	${role_admin}	admin	d86ec37e-5c02-4219-bb0d-99cb545457ff	\N	\N
a796e58d-de8c-4e25-a5b7-ccfbdd454809	5debe463-9857-47f1-8f77-552084601bcb	t	${role_create-client}	create-client	d86ec37e-5c02-4219-bb0d-99cb545457ff	5debe463-9857-47f1-8f77-552084601bcb	\N
04da60a3-ff17-452e-8151-c61a8ad6805e	5debe463-9857-47f1-8f77-552084601bcb	t	${role_view-realm}	view-realm	d86ec37e-5c02-4219-bb0d-99cb545457ff	5debe463-9857-47f1-8f77-552084601bcb	\N
ca123419-6d3a-4b19-b64f-43e2b99f24e6	5debe463-9857-47f1-8f77-552084601bcb	t	${role_view-users}	view-users	d86ec37e-5c02-4219-bb0d-99cb545457ff	5debe463-9857-47f1-8f77-552084601bcb	\N
a053f70a-542c-4784-9e60-737ae5f8edb5	5debe463-9857-47f1-8f77-552084601bcb	t	${role_view-clients}	view-clients	d86ec37e-5c02-4219-bb0d-99cb545457ff	5debe463-9857-47f1-8f77-552084601bcb	\N
045b183f-69bf-48b2-98a4-7e4d954a5212	5debe463-9857-47f1-8f77-552084601bcb	t	${role_view-events}	view-events	d86ec37e-5c02-4219-bb0d-99cb545457ff	5debe463-9857-47f1-8f77-552084601bcb	\N
01a0a587-9e4b-48e3-8b40-156f9f2a651c	5debe463-9857-47f1-8f77-552084601bcb	t	${role_view-identity-providers}	view-identity-providers	d86ec37e-5c02-4219-bb0d-99cb545457ff	5debe463-9857-47f1-8f77-552084601bcb	\N
edd46e55-d553-44ad-8ae7-42a960a6fac2	5debe463-9857-47f1-8f77-552084601bcb	t	${role_view-authorization}	view-authorization	d86ec37e-5c02-4219-bb0d-99cb545457ff	5debe463-9857-47f1-8f77-552084601bcb	\N
3db0138a-514b-4497-b205-6541e7adf8f7	5debe463-9857-47f1-8f77-552084601bcb	t	${role_manage-realm}	manage-realm	d86ec37e-5c02-4219-bb0d-99cb545457ff	5debe463-9857-47f1-8f77-552084601bcb	\N
ce2995c1-8167-4cb0-855f-71560a0f0645	5debe463-9857-47f1-8f77-552084601bcb	t	${role_manage-users}	manage-users	d86ec37e-5c02-4219-bb0d-99cb545457ff	5debe463-9857-47f1-8f77-552084601bcb	\N
fe5bfda5-50e6-4b6a-8506-cf69b66a1759	5debe463-9857-47f1-8f77-552084601bcb	t	${role_manage-clients}	manage-clients	d86ec37e-5c02-4219-bb0d-99cb545457ff	5debe463-9857-47f1-8f77-552084601bcb	\N
7612b999-60a4-44ec-aca9-1a761de54e62	5debe463-9857-47f1-8f77-552084601bcb	t	${role_manage-events}	manage-events	d86ec37e-5c02-4219-bb0d-99cb545457ff	5debe463-9857-47f1-8f77-552084601bcb	\N
b414c4be-8abb-4362-ab33-3a30b6c01fcd	5debe463-9857-47f1-8f77-552084601bcb	t	${role_manage-identity-providers}	manage-identity-providers	d86ec37e-5c02-4219-bb0d-99cb545457ff	5debe463-9857-47f1-8f77-552084601bcb	\N
835e825b-3452-4fe1-85dc-f753e70ca0f3	5debe463-9857-47f1-8f77-552084601bcb	t	${role_manage-authorization}	manage-authorization	d86ec37e-5c02-4219-bb0d-99cb545457ff	5debe463-9857-47f1-8f77-552084601bcb	\N
d4d2fd14-5864-4ef3-907f-2aa08bfc5eb4	5debe463-9857-47f1-8f77-552084601bcb	t	${role_query-users}	query-users	d86ec37e-5c02-4219-bb0d-99cb545457ff	5debe463-9857-47f1-8f77-552084601bcb	\N
013bfe1a-1207-4a31-be98-fa5eac2a0983	5debe463-9857-47f1-8f77-552084601bcb	t	${role_query-clients}	query-clients	d86ec37e-5c02-4219-bb0d-99cb545457ff	5debe463-9857-47f1-8f77-552084601bcb	\N
c9d3ec48-9ce2-40e3-a866-0a783874dc90	5debe463-9857-47f1-8f77-552084601bcb	t	${role_query-realms}	query-realms	d86ec37e-5c02-4219-bb0d-99cb545457ff	5debe463-9857-47f1-8f77-552084601bcb	\N
af539303-a04f-496d-82f0-c6c2f5050a62	5debe463-9857-47f1-8f77-552084601bcb	t	${role_query-groups}	query-groups	d86ec37e-5c02-4219-bb0d-99cb545457ff	5debe463-9857-47f1-8f77-552084601bcb	\N
fce30348-1da5-4287-a5ab-50ba3f3e5b81	2d9b5f65-2907-4e43-b54d-b5f405769ed0	t	${role_view-profile}	view-profile	d86ec37e-5c02-4219-bb0d-99cb545457ff	2d9b5f65-2907-4e43-b54d-b5f405769ed0	\N
65054880-79d1-453f-b115-9e79589dfea6	2d9b5f65-2907-4e43-b54d-b5f405769ed0	t	${role_manage-account}	manage-account	d86ec37e-5c02-4219-bb0d-99cb545457ff	2d9b5f65-2907-4e43-b54d-b5f405769ed0	\N
9ff75cd3-8fba-4ef7-b502-db65e7341062	2d9b5f65-2907-4e43-b54d-b5f405769ed0	t	${role_manage-account-links}	manage-account-links	d86ec37e-5c02-4219-bb0d-99cb545457ff	2d9b5f65-2907-4e43-b54d-b5f405769ed0	\N
17bc8ae8-138e-4a37-85b7-52e231b76f46	2d9b5f65-2907-4e43-b54d-b5f405769ed0	t	${role_view-applications}	view-applications	d86ec37e-5c02-4219-bb0d-99cb545457ff	2d9b5f65-2907-4e43-b54d-b5f405769ed0	\N
98d46a22-4870-404f-808a-4d601066115e	2d9b5f65-2907-4e43-b54d-b5f405769ed0	t	${role_view-consent}	view-consent	d86ec37e-5c02-4219-bb0d-99cb545457ff	2d9b5f65-2907-4e43-b54d-b5f405769ed0	\N
e5c9274c-55a4-4428-b4ab-387c6ee8cfb5	2d9b5f65-2907-4e43-b54d-b5f405769ed0	t	${role_manage-consent}	manage-consent	d86ec37e-5c02-4219-bb0d-99cb545457ff	2d9b5f65-2907-4e43-b54d-b5f405769ed0	\N
b521804a-e9dc-47d4-b01b-d0d3e610d1f4	2d9b5f65-2907-4e43-b54d-b5f405769ed0	t	${role_delete-account}	delete-account	d86ec37e-5c02-4219-bb0d-99cb545457ff	2d9b5f65-2907-4e43-b54d-b5f405769ed0	\N
732fe039-544b-4739-89a3-a663c4d924ea	27552099-1c6e-45c0-bced-7962d9ee6a24	t	${role_read-token}	read-token	d86ec37e-5c02-4219-bb0d-99cb545457ff	27552099-1c6e-45c0-bced-7962d9ee6a24	\N
69a6ca70-1dc5-4c68-9074-247cb5e12b5e	5debe463-9857-47f1-8f77-552084601bcb	t	${role_impersonation}	impersonation	d86ec37e-5c02-4219-bb0d-99cb545457ff	5debe463-9857-47f1-8f77-552084601bcb	\N
7538809e-9165-4753-bb76-8968bacfa374	d86ec37e-5c02-4219-bb0d-99cb545457ff	f	${role_offline-access}	offline_access	d86ec37e-5c02-4219-bb0d-99cb545457ff	\N	\N
9eab38b2-0714-4481-9cdf-8f69124422e4	d86ec37e-5c02-4219-bb0d-99cb545457ff	f	${role_uma_authorization}	uma_authorization	d86ec37e-5c02-4219-bb0d-99cb545457ff	\N	\N
e8eb2cf0-e9ff-4e80-ae1f-3dca2cd64a9c	ba1a6f7d-badd-4ac5-9ce3-3a5dc0dd1d0b	f	${role_default-roles}	default-roles-poc-realm	ba1a6f7d-badd-4ac5-9ce3-3a5dc0dd1d0b	\N	\N
2f97a10b-f583-464c-a411-98aa393e4b7a	d3a1c55d-68b9-41f2-ad98-a8bcb669d6aa	t	${role_create-client}	create-client	d86ec37e-5c02-4219-bb0d-99cb545457ff	d3a1c55d-68b9-41f2-ad98-a8bcb669d6aa	\N
9236c4f8-b43e-4a62-8884-a7d4edca80fc	d3a1c55d-68b9-41f2-ad98-a8bcb669d6aa	t	${role_view-realm}	view-realm	d86ec37e-5c02-4219-bb0d-99cb545457ff	d3a1c55d-68b9-41f2-ad98-a8bcb669d6aa	\N
97a06a03-91cd-42f2-ab7a-98413a43a95d	d3a1c55d-68b9-41f2-ad98-a8bcb669d6aa	t	${role_view-users}	view-users	d86ec37e-5c02-4219-bb0d-99cb545457ff	d3a1c55d-68b9-41f2-ad98-a8bcb669d6aa	\N
1531b637-e05c-41ba-8330-6eb63098462d	d3a1c55d-68b9-41f2-ad98-a8bcb669d6aa	t	${role_view-clients}	view-clients	d86ec37e-5c02-4219-bb0d-99cb545457ff	d3a1c55d-68b9-41f2-ad98-a8bcb669d6aa	\N
ffb6f18d-1fe3-4c52-ae7d-daffc618c73c	d3a1c55d-68b9-41f2-ad98-a8bcb669d6aa	t	${role_view-events}	view-events	d86ec37e-5c02-4219-bb0d-99cb545457ff	d3a1c55d-68b9-41f2-ad98-a8bcb669d6aa	\N
ace72609-bcc8-4a5d-a087-1ebcad80e1ad	d3a1c55d-68b9-41f2-ad98-a8bcb669d6aa	t	${role_view-identity-providers}	view-identity-providers	d86ec37e-5c02-4219-bb0d-99cb545457ff	d3a1c55d-68b9-41f2-ad98-a8bcb669d6aa	\N
2bc0a4cb-4dfa-4e5c-b529-a4813cb409c4	d3a1c55d-68b9-41f2-ad98-a8bcb669d6aa	t	${role_view-authorization}	view-authorization	d86ec37e-5c02-4219-bb0d-99cb545457ff	d3a1c55d-68b9-41f2-ad98-a8bcb669d6aa	\N
b5835510-eb31-45d0-95a7-9a6304e8c4e8	d3a1c55d-68b9-41f2-ad98-a8bcb669d6aa	t	${role_manage-realm}	manage-realm	d86ec37e-5c02-4219-bb0d-99cb545457ff	d3a1c55d-68b9-41f2-ad98-a8bcb669d6aa	\N
3f58b0fb-e112-49b7-9234-c7d8cc858f0b	d3a1c55d-68b9-41f2-ad98-a8bcb669d6aa	t	${role_manage-users}	manage-users	d86ec37e-5c02-4219-bb0d-99cb545457ff	d3a1c55d-68b9-41f2-ad98-a8bcb669d6aa	\N
7a3d5de2-bf45-49b3-9895-17c1f49021ae	d3a1c55d-68b9-41f2-ad98-a8bcb669d6aa	t	${role_manage-clients}	manage-clients	d86ec37e-5c02-4219-bb0d-99cb545457ff	d3a1c55d-68b9-41f2-ad98-a8bcb669d6aa	\N
bdf61488-83d4-4827-b29c-76c7742f4ae8	d3a1c55d-68b9-41f2-ad98-a8bcb669d6aa	t	${role_manage-events}	manage-events	d86ec37e-5c02-4219-bb0d-99cb545457ff	d3a1c55d-68b9-41f2-ad98-a8bcb669d6aa	\N
208cd93f-5203-4317-aadd-01c04fdbb3cf	d3a1c55d-68b9-41f2-ad98-a8bcb669d6aa	t	${role_manage-identity-providers}	manage-identity-providers	d86ec37e-5c02-4219-bb0d-99cb545457ff	d3a1c55d-68b9-41f2-ad98-a8bcb669d6aa	\N
c041354d-8bda-465e-93af-cafab43337e4	d3a1c55d-68b9-41f2-ad98-a8bcb669d6aa	t	${role_manage-authorization}	manage-authorization	d86ec37e-5c02-4219-bb0d-99cb545457ff	d3a1c55d-68b9-41f2-ad98-a8bcb669d6aa	\N
6324675f-72a2-4c43-b07c-96065f63ca6e	d3a1c55d-68b9-41f2-ad98-a8bcb669d6aa	t	${role_query-users}	query-users	d86ec37e-5c02-4219-bb0d-99cb545457ff	d3a1c55d-68b9-41f2-ad98-a8bcb669d6aa	\N
00974d45-b847-4e7c-bf04-a3e6700eaa15	d3a1c55d-68b9-41f2-ad98-a8bcb669d6aa	t	${role_query-clients}	query-clients	d86ec37e-5c02-4219-bb0d-99cb545457ff	d3a1c55d-68b9-41f2-ad98-a8bcb669d6aa	\N
33bb94d4-a7c3-40f2-9607-2d1204d99268	d3a1c55d-68b9-41f2-ad98-a8bcb669d6aa	t	${role_query-realms}	query-realms	d86ec37e-5c02-4219-bb0d-99cb545457ff	d3a1c55d-68b9-41f2-ad98-a8bcb669d6aa	\N
ea48937f-7aaa-4650-a5f7-323c950737ee	d3a1c55d-68b9-41f2-ad98-a8bcb669d6aa	t	${role_query-groups}	query-groups	d86ec37e-5c02-4219-bb0d-99cb545457ff	d3a1c55d-68b9-41f2-ad98-a8bcb669d6aa	\N
f840319e-f887-4327-8b6e-cb88bccaf44b	15b9a376-d8eb-4797-a671-890e4fbe85f6	t	${role_realm-admin}	realm-admin	ba1a6f7d-badd-4ac5-9ce3-3a5dc0dd1d0b	15b9a376-d8eb-4797-a671-890e4fbe85f6	\N
db42c8ed-1c71-4c23-b89a-b7b2773cb0b8	15b9a376-d8eb-4797-a671-890e4fbe85f6	t	${role_create-client}	create-client	ba1a6f7d-badd-4ac5-9ce3-3a5dc0dd1d0b	15b9a376-d8eb-4797-a671-890e4fbe85f6	\N
c5a17dee-7cad-421d-8855-c7782bd1b102	15b9a376-d8eb-4797-a671-890e4fbe85f6	t	${role_view-realm}	view-realm	ba1a6f7d-badd-4ac5-9ce3-3a5dc0dd1d0b	15b9a376-d8eb-4797-a671-890e4fbe85f6	\N
142afab5-1d19-4ccb-82e3-4cd2d316f9aa	15b9a376-d8eb-4797-a671-890e4fbe85f6	t	${role_view-users}	view-users	ba1a6f7d-badd-4ac5-9ce3-3a5dc0dd1d0b	15b9a376-d8eb-4797-a671-890e4fbe85f6	\N
28ef59ed-5539-434c-a62d-5f5638664b44	15b9a376-d8eb-4797-a671-890e4fbe85f6	t	${role_view-clients}	view-clients	ba1a6f7d-badd-4ac5-9ce3-3a5dc0dd1d0b	15b9a376-d8eb-4797-a671-890e4fbe85f6	\N
1ee268cf-2f40-4660-9765-eb5e7e377961	15b9a376-d8eb-4797-a671-890e4fbe85f6	t	${role_view-events}	view-events	ba1a6f7d-badd-4ac5-9ce3-3a5dc0dd1d0b	15b9a376-d8eb-4797-a671-890e4fbe85f6	\N
a739190b-2b25-4d87-ac0d-27d49d529d15	15b9a376-d8eb-4797-a671-890e4fbe85f6	t	${role_view-identity-providers}	view-identity-providers	ba1a6f7d-badd-4ac5-9ce3-3a5dc0dd1d0b	15b9a376-d8eb-4797-a671-890e4fbe85f6	\N
efcfb99c-172c-4796-876c-68d161f69093	15b9a376-d8eb-4797-a671-890e4fbe85f6	t	${role_view-authorization}	view-authorization	ba1a6f7d-badd-4ac5-9ce3-3a5dc0dd1d0b	15b9a376-d8eb-4797-a671-890e4fbe85f6	\N
8932a2e2-b7ae-4769-8cbd-bf989ba6673b	15b9a376-d8eb-4797-a671-890e4fbe85f6	t	${role_manage-realm}	manage-realm	ba1a6f7d-badd-4ac5-9ce3-3a5dc0dd1d0b	15b9a376-d8eb-4797-a671-890e4fbe85f6	\N
7265390b-838a-4b5d-8977-d6827b7e1e96	15b9a376-d8eb-4797-a671-890e4fbe85f6	t	${role_manage-users}	manage-users	ba1a6f7d-badd-4ac5-9ce3-3a5dc0dd1d0b	15b9a376-d8eb-4797-a671-890e4fbe85f6	\N
edd701cc-50d8-4b57-ba4a-e712e178b5b2	15b9a376-d8eb-4797-a671-890e4fbe85f6	t	${role_manage-clients}	manage-clients	ba1a6f7d-badd-4ac5-9ce3-3a5dc0dd1d0b	15b9a376-d8eb-4797-a671-890e4fbe85f6	\N
d42d77d6-d422-438f-9842-3c3ba468bcf7	15b9a376-d8eb-4797-a671-890e4fbe85f6	t	${role_manage-events}	manage-events	ba1a6f7d-badd-4ac5-9ce3-3a5dc0dd1d0b	15b9a376-d8eb-4797-a671-890e4fbe85f6	\N
95eb4f4e-7044-4c73-a409-18593db44e91	15b9a376-d8eb-4797-a671-890e4fbe85f6	t	${role_manage-identity-providers}	manage-identity-providers	ba1a6f7d-badd-4ac5-9ce3-3a5dc0dd1d0b	15b9a376-d8eb-4797-a671-890e4fbe85f6	\N
3dcc9f54-3ead-4751-ae7e-1d32e56af58f	15b9a376-d8eb-4797-a671-890e4fbe85f6	t	${role_manage-authorization}	manage-authorization	ba1a6f7d-badd-4ac5-9ce3-3a5dc0dd1d0b	15b9a376-d8eb-4797-a671-890e4fbe85f6	\N
024b2c05-277b-47d6-a82e-81f8cfb617fb	15b9a376-d8eb-4797-a671-890e4fbe85f6	t	${role_query-users}	query-users	ba1a6f7d-badd-4ac5-9ce3-3a5dc0dd1d0b	15b9a376-d8eb-4797-a671-890e4fbe85f6	\N
e5e26d94-c41e-4998-9eb3-a6203d57186d	15b9a376-d8eb-4797-a671-890e4fbe85f6	t	${role_query-clients}	query-clients	ba1a6f7d-badd-4ac5-9ce3-3a5dc0dd1d0b	15b9a376-d8eb-4797-a671-890e4fbe85f6	\N
fa4d716e-6b14-49ef-a227-c157d4637d62	15b9a376-d8eb-4797-a671-890e4fbe85f6	t	${role_query-realms}	query-realms	ba1a6f7d-badd-4ac5-9ce3-3a5dc0dd1d0b	15b9a376-d8eb-4797-a671-890e4fbe85f6	\N
2eca9dcb-86b4-4c7a-adbb-585aade2c725	15b9a376-d8eb-4797-a671-890e4fbe85f6	t	${role_query-groups}	query-groups	ba1a6f7d-badd-4ac5-9ce3-3a5dc0dd1d0b	15b9a376-d8eb-4797-a671-890e4fbe85f6	\N
25d6b3dd-97d2-4727-af9c-0624f1ac3941	6899b2e9-8cdb-41ad-b45f-c4a40fd40621	t	${role_view-profile}	view-profile	ba1a6f7d-badd-4ac5-9ce3-3a5dc0dd1d0b	6899b2e9-8cdb-41ad-b45f-c4a40fd40621	\N
c759a209-0098-4865-a3cc-7415fe3ba038	6899b2e9-8cdb-41ad-b45f-c4a40fd40621	t	${role_manage-account}	manage-account	ba1a6f7d-badd-4ac5-9ce3-3a5dc0dd1d0b	6899b2e9-8cdb-41ad-b45f-c4a40fd40621	\N
7ef2a2ed-687e-4e39-a62b-900b5289b95f	6899b2e9-8cdb-41ad-b45f-c4a40fd40621	t	${role_manage-account-links}	manage-account-links	ba1a6f7d-badd-4ac5-9ce3-3a5dc0dd1d0b	6899b2e9-8cdb-41ad-b45f-c4a40fd40621	\N
bf3c299e-280a-46b1-bfff-cf94700f5a11	6899b2e9-8cdb-41ad-b45f-c4a40fd40621	t	${role_view-applications}	view-applications	ba1a6f7d-badd-4ac5-9ce3-3a5dc0dd1d0b	6899b2e9-8cdb-41ad-b45f-c4a40fd40621	\N
5fd63e3e-a5a2-4f0f-9399-a3f3df4c654c	6899b2e9-8cdb-41ad-b45f-c4a40fd40621	t	${role_view-consent}	view-consent	ba1a6f7d-badd-4ac5-9ce3-3a5dc0dd1d0b	6899b2e9-8cdb-41ad-b45f-c4a40fd40621	\N
87d783d1-0c90-44eb-8071-3d638494e943	6899b2e9-8cdb-41ad-b45f-c4a40fd40621	t	${role_manage-consent}	manage-consent	ba1a6f7d-badd-4ac5-9ce3-3a5dc0dd1d0b	6899b2e9-8cdb-41ad-b45f-c4a40fd40621	\N
40e3079e-1d17-4948-b82d-84f077e96e69	6899b2e9-8cdb-41ad-b45f-c4a40fd40621	t	${role_delete-account}	delete-account	ba1a6f7d-badd-4ac5-9ce3-3a5dc0dd1d0b	6899b2e9-8cdb-41ad-b45f-c4a40fd40621	\N
a8601155-8088-41ad-a7a0-40e4804ca29a	d3a1c55d-68b9-41f2-ad98-a8bcb669d6aa	t	${role_impersonation}	impersonation	d86ec37e-5c02-4219-bb0d-99cb545457ff	d3a1c55d-68b9-41f2-ad98-a8bcb669d6aa	\N
1ae51603-6b8a-4c6a-8b34-c8a70e8f2aed	15b9a376-d8eb-4797-a671-890e4fbe85f6	t	${role_impersonation}	impersonation	ba1a6f7d-badd-4ac5-9ce3-3a5dc0dd1d0b	15b9a376-d8eb-4797-a671-890e4fbe85f6	\N
c32d7342-f589-4c62-93f2-c85e9256397e	6091eac0-f623-46e9-9e12-43e23d3dd79f	t	${role_read-token}	read-token	ba1a6f7d-badd-4ac5-9ce3-3a5dc0dd1d0b	6091eac0-f623-46e9-9e12-43e23d3dd79f	\N
7d88dd7c-45f1-4d3e-85e6-3e262c6b726f	ba1a6f7d-badd-4ac5-9ce3-3a5dc0dd1d0b	f	${role_offline-access}	offline_access	ba1a6f7d-badd-4ac5-9ce3-3a5dc0dd1d0b	\N	\N
c4252ac9-3bc6-4413-8d73-3411a0d803a8	ba1a6f7d-badd-4ac5-9ce3-3a5dc0dd1d0b	f	${role_uma_authorization}	uma_authorization	ba1a6f7d-badd-4ac5-9ce3-3a5dc0dd1d0b	\N	\N
dae8bb37-384b-451b-a0ab-1bcdbc7eb980	ba1a6f7d-badd-4ac5-9ce3-3a5dc0dd1d0b	f		another_realm_role	ba1a6f7d-badd-4ac5-9ce3-3a5dc0dd1d0b	\N	\N
76b339f3-2fcd-416e-9a8c-7b1dff81b2c8	ba1a6f7d-badd-4ac5-9ce3-3a5dc0dd1d0b	f		my_realm_role	ba1a6f7d-badd-4ac5-9ce3-3a5dc0dd1d0b	\N	\N
5ebadddf-23f9-4b76-92a9-5e81d33077b6	ba1a6f7d-badd-4ac5-9ce3-3a5dc0dd1d0b	f		the_group_role	ba1a6f7d-badd-4ac5-9ce3-3a5dc0dd1d0b	\N	\N
4cb40f78-fb1d-4f58-a692-596d237a6784	1ce59c97-2365-4484-80b6-3c471172f3be	t	\N	custom_client_role	ba1a6f7d-badd-4ac5-9ce3-3a5dc0dd1d0b	1ce59c97-2365-4484-80b6-3c471172f3be	\N
\.


--
-- Data for Name: migration_model; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.migration_model (id, version, update_time) FROM stdin;
tiim1	19.0.1	1661337654
\.


--
-- Data for Name: offline_client_session; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.offline_client_session (user_session_id, client_id, offline_flag, "timestamp", data, client_storage_provider, external_client_id) FROM stdin;
\.


--
-- Data for Name: offline_user_session; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.offline_user_session (user_session_id, user_id, realm_id, created_on, offline_flag, data, last_session_refresh) FROM stdin;
\.


--
-- Data for Name: policy_config; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.policy_config (policy_id, name, value) FROM stdin;
\.


--
-- Data for Name: protocol_mapper; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) FROM stdin;
13896dfc-89d4-4350-97fd-0809e484d65d	audience resolve	openid-connect	oidc-audience-resolve-mapper	b0c07851-5a13-4c04-8167-eb74fe4bf073	\N
a13c5dff-dc15-4f8a-b124-b2e4ac85acd4	locale	openid-connect	oidc-usermodel-attribute-mapper	e12365ba-b577-4fb1-acec-d10e2a6fd9a0	\N
7a18aaf7-2c36-4c4d-bc01-361b1539c278	role list	saml	saml-role-list-mapper	\N	35336663-16ef-418f-a063-1cfd0363c77b
d064402c-dbaa-48cc-bd33-335fcb01deb0	full name	openid-connect	oidc-full-name-mapper	\N	d0004cee-7d50-4c70-98b0-c2ab20de8c24
8f87ab44-cfce-40e4-9a44-ff0d3c64733d	family name	openid-connect	oidc-usermodel-property-mapper	\N	d0004cee-7d50-4c70-98b0-c2ab20de8c24
709454ab-a619-4371-932a-26ddddbd0723	given name	openid-connect	oidc-usermodel-property-mapper	\N	d0004cee-7d50-4c70-98b0-c2ab20de8c24
6c6bee4d-8ab6-40da-88f7-2391b310d3af	middle name	openid-connect	oidc-usermodel-attribute-mapper	\N	d0004cee-7d50-4c70-98b0-c2ab20de8c24
4334c3b2-862f-4716-a36e-b7dae111ce10	nickname	openid-connect	oidc-usermodel-attribute-mapper	\N	d0004cee-7d50-4c70-98b0-c2ab20de8c24
1437b972-2d01-49a6-a1fe-3f818855ee30	username	openid-connect	oidc-usermodel-property-mapper	\N	d0004cee-7d50-4c70-98b0-c2ab20de8c24
51224913-a987-4b84-86af-8e65ca6ec0bb	profile	openid-connect	oidc-usermodel-attribute-mapper	\N	d0004cee-7d50-4c70-98b0-c2ab20de8c24
0c80b370-f8ff-4315-8c5e-086e9e2e4e85	picture	openid-connect	oidc-usermodel-attribute-mapper	\N	d0004cee-7d50-4c70-98b0-c2ab20de8c24
1b29f684-d756-41cd-8b36-1e0501d61620	website	openid-connect	oidc-usermodel-attribute-mapper	\N	d0004cee-7d50-4c70-98b0-c2ab20de8c24
d73f5624-1934-4d8f-8c34-a81097a31ea0	gender	openid-connect	oidc-usermodel-attribute-mapper	\N	d0004cee-7d50-4c70-98b0-c2ab20de8c24
3a6ca300-abdd-4270-b8a0-f38de5363ce0	birthdate	openid-connect	oidc-usermodel-attribute-mapper	\N	d0004cee-7d50-4c70-98b0-c2ab20de8c24
b77c8718-3d90-4384-b63a-834ec52eebf5	zoneinfo	openid-connect	oidc-usermodel-attribute-mapper	\N	d0004cee-7d50-4c70-98b0-c2ab20de8c24
0a51a59c-d1e2-45e2-8598-01f441085d58	locale	openid-connect	oidc-usermodel-attribute-mapper	\N	d0004cee-7d50-4c70-98b0-c2ab20de8c24
8ce5035d-7cb5-499c-af73-37f2910c88ce	updated at	openid-connect	oidc-usermodel-attribute-mapper	\N	d0004cee-7d50-4c70-98b0-c2ab20de8c24
366eb9bd-d4ab-4641-a348-8ae86978bb09	email	openid-connect	oidc-usermodel-property-mapper	\N	b0fc516e-9351-46b4-8c8d-08fdddfab057
2a20c8f8-92d8-4e0e-80d0-4fbcd1074f0d	email verified	openid-connect	oidc-usermodel-property-mapper	\N	b0fc516e-9351-46b4-8c8d-08fdddfab057
eb697f04-4f21-460a-9594-aefcdf3dadbd	address	openid-connect	oidc-address-mapper	\N	9cac0c30-60d3-436d-8444-00f046b7e5ca
13c2d730-0ae1-4222-b51f-e94b158807c3	phone number	openid-connect	oidc-usermodel-attribute-mapper	\N	f013df01-3a46-4633-b587-79af1d435e3b
5eac9cfa-b7a4-4c46-8e3c-e5ebe1e7fa12	phone number verified	openid-connect	oidc-usermodel-attribute-mapper	\N	f013df01-3a46-4633-b587-79af1d435e3b
6024a670-7508-4a69-b2bf-31fcd1efd73b	realm roles	openid-connect	oidc-usermodel-realm-role-mapper	\N	b09bf549-596a-4034-9329-04375128a29f
0a7f0511-a05e-42c4-968b-fbd10ccf1f8c	client roles	openid-connect	oidc-usermodel-client-role-mapper	\N	b09bf549-596a-4034-9329-04375128a29f
627010d3-c14f-417c-8f63-4357760434ff	audience resolve	openid-connect	oidc-audience-resolve-mapper	\N	b09bf549-596a-4034-9329-04375128a29f
fbe07ea8-fa32-4fb1-afe9-05ff6a96de20	allowed web origins	openid-connect	oidc-allowed-origins-mapper	\N	086d7bf5-cfff-4609-8aba-5461aea83734
23060161-4b2b-4551-9c1d-f2f4d58a105e	upn	openid-connect	oidc-usermodel-property-mapper	\N	f1537516-3935-4b25-a382-71055478cbff
0c1fdd36-4192-47f7-9fc7-766b6c56794c	groups	openid-connect	oidc-usermodel-realm-role-mapper	\N	f1537516-3935-4b25-a382-71055478cbff
bc4d7b24-40a5-4974-a286-4a0a03c9b440	acr loa level	openid-connect	oidc-acr-mapper	\N	db4509b6-791c-40e4-bba6-a85e67b9a25e
408ec5e4-2b20-4083-a5df-f94b07cae3d8	audience resolve	openid-connect	oidc-audience-resolve-mapper	7a7e6753-8234-49ad-8473-0425c343131c	\N
78d1eecf-e1d8-4af8-b219-78f9c454dc88	role list	saml	saml-role-list-mapper	\N	54a89283-5d57-478d-bf78-c6b557b19f94
401d99a0-2223-4fca-a249-7a6fcadb91b4	full name	openid-connect	oidc-full-name-mapper	\N	8dcda776-69c3-41df-a9fe-82ad55a65537
bb85e27d-0e8d-486c-b076-408952952ca4	family name	openid-connect	oidc-usermodel-property-mapper	\N	8dcda776-69c3-41df-a9fe-82ad55a65537
88cbb353-04c0-4c29-a657-90ed106ca10e	given name	openid-connect	oidc-usermodel-property-mapper	\N	8dcda776-69c3-41df-a9fe-82ad55a65537
6525686a-b022-4440-b92e-9a83666c5cfd	middle name	openid-connect	oidc-usermodel-attribute-mapper	\N	8dcda776-69c3-41df-a9fe-82ad55a65537
933ae076-bfba-4735-83a3-04da296892f4	nickname	openid-connect	oidc-usermodel-attribute-mapper	\N	8dcda776-69c3-41df-a9fe-82ad55a65537
0cf409d9-5dfd-4b03-b12b-da3439ce0019	username	openid-connect	oidc-usermodel-property-mapper	\N	8dcda776-69c3-41df-a9fe-82ad55a65537
9315b0b5-8187-48f7-bd6c-26499e63f086	profile	openid-connect	oidc-usermodel-attribute-mapper	\N	8dcda776-69c3-41df-a9fe-82ad55a65537
66d112ce-e8bb-48ab-9316-ae2283b136c5	picture	openid-connect	oidc-usermodel-attribute-mapper	\N	8dcda776-69c3-41df-a9fe-82ad55a65537
f3428623-4d17-4746-9e93-5062f355f7c3	website	openid-connect	oidc-usermodel-attribute-mapper	\N	8dcda776-69c3-41df-a9fe-82ad55a65537
ca1d30f2-d081-4e03-8134-f265c6d11c6a	gender	openid-connect	oidc-usermodel-attribute-mapper	\N	8dcda776-69c3-41df-a9fe-82ad55a65537
fd5a6c0a-8d42-4902-afe5-1a87e8106f50	birthdate	openid-connect	oidc-usermodel-attribute-mapper	\N	8dcda776-69c3-41df-a9fe-82ad55a65537
cdb8f8a0-0194-42ad-9f6f-4878f9f7aa98	zoneinfo	openid-connect	oidc-usermodel-attribute-mapper	\N	8dcda776-69c3-41df-a9fe-82ad55a65537
be9c12f0-dbdb-489d-8b57-746998252fb8	locale	openid-connect	oidc-usermodel-attribute-mapper	\N	8dcda776-69c3-41df-a9fe-82ad55a65537
856a1e8f-7893-41b9-8c27-a5c509e713a1	updated at	openid-connect	oidc-usermodel-attribute-mapper	\N	8dcda776-69c3-41df-a9fe-82ad55a65537
2e85cf3a-2c0d-4fe9-b919-e4dabf44be5f	email	openid-connect	oidc-usermodel-property-mapper	\N	c11595f8-0c6a-4325-9610-cceb12f45a0e
8474b90a-b251-4097-aab8-c5351f1997d8	email verified	openid-connect	oidc-usermodel-property-mapper	\N	c11595f8-0c6a-4325-9610-cceb12f45a0e
e95c5176-de2a-4cec-95c2-35608a9614fd	address	openid-connect	oidc-address-mapper	\N	d56fa960-c2d6-48e9-ba20-dd229d6419d7
22e5fe50-3f80-44c1-b9aa-2819f14a6ab9	phone number	openid-connect	oidc-usermodel-attribute-mapper	\N	65b8f3f8-bbac-4f62-91e0-583f4acd826a
84cdebf9-8d78-4d98-b28a-21c1b735f645	phone number verified	openid-connect	oidc-usermodel-attribute-mapper	\N	65b8f3f8-bbac-4f62-91e0-583f4acd826a
f26600a3-ef47-4668-aca7-9f537f89ef0b	realm roles	openid-connect	oidc-usermodel-realm-role-mapper	\N	a261d167-16bd-4e94-8067-957670b876a0
55ba3e4d-7084-4275-800a-e49bb29f67f7	client roles	openid-connect	oidc-usermodel-client-role-mapper	\N	a261d167-16bd-4e94-8067-957670b876a0
cd21b8d5-5339-4cef-bcb1-eb081f7145d2	audience resolve	openid-connect	oidc-audience-resolve-mapper	\N	a261d167-16bd-4e94-8067-957670b876a0
ba9ee8d5-485d-4de8-a0e3-1a22b63b5f80	allowed web origins	openid-connect	oidc-allowed-origins-mapper	\N	ebbd03b4-43c2-4d7d-80ab-4f62aeffd088
52fca26e-3c2d-443c-b73d-f2aaaeb57f4f	upn	openid-connect	oidc-usermodel-property-mapper	\N	0d56fbd7-1120-41df-96ec-760c3cd9f088
1b1a8b99-1e1f-4420-82df-f04db390de1f	groups	openid-connect	oidc-usermodel-realm-role-mapper	\N	0d56fbd7-1120-41df-96ec-760c3cd9f088
d1561e2b-3c49-4436-a009-05cbe0ce2027	acr loa level	openid-connect	oidc-acr-mapper	\N	53149023-1608-4a72-b605-a330acf727d1
aa8a22d3-b8ec-4bd5-a83b-48ba777299d7	locale	openid-connect	oidc-usermodel-attribute-mapper	33b7bec8-88a8-4526-81f1-4c14bc121bf2	\N
7d2e1477-71c7-4266-a8a3-d499f15a7d36	my_hardcoded_claim	openid-connect	oidc-hardcoded-claim-mapper	1ce59c97-2365-4484-80b6-3c471172f3be	\N
\.


--
-- Data for Name: protocol_mapper_config; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.protocol_mapper_config (protocol_mapper_id, value, name) FROM stdin;
a13c5dff-dc15-4f8a-b124-b2e4ac85acd4	true	userinfo.token.claim
a13c5dff-dc15-4f8a-b124-b2e4ac85acd4	locale	user.attribute
a13c5dff-dc15-4f8a-b124-b2e4ac85acd4	true	id.token.claim
a13c5dff-dc15-4f8a-b124-b2e4ac85acd4	true	access.token.claim
a13c5dff-dc15-4f8a-b124-b2e4ac85acd4	locale	claim.name
a13c5dff-dc15-4f8a-b124-b2e4ac85acd4	String	jsonType.label
7a18aaf7-2c36-4c4d-bc01-361b1539c278	false	single
7a18aaf7-2c36-4c4d-bc01-361b1539c278	Basic	attribute.nameformat
7a18aaf7-2c36-4c4d-bc01-361b1539c278	Role	attribute.name
0a51a59c-d1e2-45e2-8598-01f441085d58	true	userinfo.token.claim
0a51a59c-d1e2-45e2-8598-01f441085d58	locale	user.attribute
0a51a59c-d1e2-45e2-8598-01f441085d58	true	id.token.claim
0a51a59c-d1e2-45e2-8598-01f441085d58	true	access.token.claim
0a51a59c-d1e2-45e2-8598-01f441085d58	locale	claim.name
0a51a59c-d1e2-45e2-8598-01f441085d58	String	jsonType.label
0c80b370-f8ff-4315-8c5e-086e9e2e4e85	true	userinfo.token.claim
0c80b370-f8ff-4315-8c5e-086e9e2e4e85	picture	user.attribute
0c80b370-f8ff-4315-8c5e-086e9e2e4e85	true	id.token.claim
0c80b370-f8ff-4315-8c5e-086e9e2e4e85	true	access.token.claim
0c80b370-f8ff-4315-8c5e-086e9e2e4e85	picture	claim.name
0c80b370-f8ff-4315-8c5e-086e9e2e4e85	String	jsonType.label
1437b972-2d01-49a6-a1fe-3f818855ee30	true	userinfo.token.claim
1437b972-2d01-49a6-a1fe-3f818855ee30	username	user.attribute
1437b972-2d01-49a6-a1fe-3f818855ee30	true	id.token.claim
1437b972-2d01-49a6-a1fe-3f818855ee30	true	access.token.claim
1437b972-2d01-49a6-a1fe-3f818855ee30	preferred_username	claim.name
1437b972-2d01-49a6-a1fe-3f818855ee30	String	jsonType.label
1b29f684-d756-41cd-8b36-1e0501d61620	true	userinfo.token.claim
1b29f684-d756-41cd-8b36-1e0501d61620	website	user.attribute
1b29f684-d756-41cd-8b36-1e0501d61620	true	id.token.claim
1b29f684-d756-41cd-8b36-1e0501d61620	true	access.token.claim
1b29f684-d756-41cd-8b36-1e0501d61620	website	claim.name
1b29f684-d756-41cd-8b36-1e0501d61620	String	jsonType.label
3a6ca300-abdd-4270-b8a0-f38de5363ce0	true	userinfo.token.claim
3a6ca300-abdd-4270-b8a0-f38de5363ce0	birthdate	user.attribute
3a6ca300-abdd-4270-b8a0-f38de5363ce0	true	id.token.claim
3a6ca300-abdd-4270-b8a0-f38de5363ce0	true	access.token.claim
3a6ca300-abdd-4270-b8a0-f38de5363ce0	birthdate	claim.name
3a6ca300-abdd-4270-b8a0-f38de5363ce0	String	jsonType.label
4334c3b2-862f-4716-a36e-b7dae111ce10	true	userinfo.token.claim
4334c3b2-862f-4716-a36e-b7dae111ce10	nickname	user.attribute
4334c3b2-862f-4716-a36e-b7dae111ce10	true	id.token.claim
4334c3b2-862f-4716-a36e-b7dae111ce10	true	access.token.claim
4334c3b2-862f-4716-a36e-b7dae111ce10	nickname	claim.name
4334c3b2-862f-4716-a36e-b7dae111ce10	String	jsonType.label
51224913-a987-4b84-86af-8e65ca6ec0bb	true	userinfo.token.claim
51224913-a987-4b84-86af-8e65ca6ec0bb	profile	user.attribute
51224913-a987-4b84-86af-8e65ca6ec0bb	true	id.token.claim
51224913-a987-4b84-86af-8e65ca6ec0bb	true	access.token.claim
51224913-a987-4b84-86af-8e65ca6ec0bb	profile	claim.name
51224913-a987-4b84-86af-8e65ca6ec0bb	String	jsonType.label
6c6bee4d-8ab6-40da-88f7-2391b310d3af	true	userinfo.token.claim
6c6bee4d-8ab6-40da-88f7-2391b310d3af	middleName	user.attribute
6c6bee4d-8ab6-40da-88f7-2391b310d3af	true	id.token.claim
6c6bee4d-8ab6-40da-88f7-2391b310d3af	true	access.token.claim
6c6bee4d-8ab6-40da-88f7-2391b310d3af	middle_name	claim.name
6c6bee4d-8ab6-40da-88f7-2391b310d3af	String	jsonType.label
709454ab-a619-4371-932a-26ddddbd0723	true	userinfo.token.claim
709454ab-a619-4371-932a-26ddddbd0723	firstName	user.attribute
709454ab-a619-4371-932a-26ddddbd0723	true	id.token.claim
709454ab-a619-4371-932a-26ddddbd0723	true	access.token.claim
709454ab-a619-4371-932a-26ddddbd0723	given_name	claim.name
709454ab-a619-4371-932a-26ddddbd0723	String	jsonType.label
8ce5035d-7cb5-499c-af73-37f2910c88ce	true	userinfo.token.claim
8ce5035d-7cb5-499c-af73-37f2910c88ce	updatedAt	user.attribute
8ce5035d-7cb5-499c-af73-37f2910c88ce	true	id.token.claim
8ce5035d-7cb5-499c-af73-37f2910c88ce	true	access.token.claim
8ce5035d-7cb5-499c-af73-37f2910c88ce	updated_at	claim.name
8ce5035d-7cb5-499c-af73-37f2910c88ce	long	jsonType.label
8f87ab44-cfce-40e4-9a44-ff0d3c64733d	true	userinfo.token.claim
8f87ab44-cfce-40e4-9a44-ff0d3c64733d	lastName	user.attribute
8f87ab44-cfce-40e4-9a44-ff0d3c64733d	true	id.token.claim
8f87ab44-cfce-40e4-9a44-ff0d3c64733d	true	access.token.claim
8f87ab44-cfce-40e4-9a44-ff0d3c64733d	family_name	claim.name
8f87ab44-cfce-40e4-9a44-ff0d3c64733d	String	jsonType.label
b77c8718-3d90-4384-b63a-834ec52eebf5	true	userinfo.token.claim
b77c8718-3d90-4384-b63a-834ec52eebf5	zoneinfo	user.attribute
b77c8718-3d90-4384-b63a-834ec52eebf5	true	id.token.claim
b77c8718-3d90-4384-b63a-834ec52eebf5	true	access.token.claim
b77c8718-3d90-4384-b63a-834ec52eebf5	zoneinfo	claim.name
b77c8718-3d90-4384-b63a-834ec52eebf5	String	jsonType.label
d064402c-dbaa-48cc-bd33-335fcb01deb0	true	userinfo.token.claim
d064402c-dbaa-48cc-bd33-335fcb01deb0	true	id.token.claim
d064402c-dbaa-48cc-bd33-335fcb01deb0	true	access.token.claim
d73f5624-1934-4d8f-8c34-a81097a31ea0	true	userinfo.token.claim
d73f5624-1934-4d8f-8c34-a81097a31ea0	gender	user.attribute
d73f5624-1934-4d8f-8c34-a81097a31ea0	true	id.token.claim
d73f5624-1934-4d8f-8c34-a81097a31ea0	true	access.token.claim
d73f5624-1934-4d8f-8c34-a81097a31ea0	gender	claim.name
d73f5624-1934-4d8f-8c34-a81097a31ea0	String	jsonType.label
2a20c8f8-92d8-4e0e-80d0-4fbcd1074f0d	true	userinfo.token.claim
2a20c8f8-92d8-4e0e-80d0-4fbcd1074f0d	emailVerified	user.attribute
2a20c8f8-92d8-4e0e-80d0-4fbcd1074f0d	true	id.token.claim
2a20c8f8-92d8-4e0e-80d0-4fbcd1074f0d	true	access.token.claim
2a20c8f8-92d8-4e0e-80d0-4fbcd1074f0d	email_verified	claim.name
2a20c8f8-92d8-4e0e-80d0-4fbcd1074f0d	boolean	jsonType.label
366eb9bd-d4ab-4641-a348-8ae86978bb09	true	userinfo.token.claim
366eb9bd-d4ab-4641-a348-8ae86978bb09	email	user.attribute
366eb9bd-d4ab-4641-a348-8ae86978bb09	true	id.token.claim
366eb9bd-d4ab-4641-a348-8ae86978bb09	true	access.token.claim
366eb9bd-d4ab-4641-a348-8ae86978bb09	email	claim.name
366eb9bd-d4ab-4641-a348-8ae86978bb09	String	jsonType.label
eb697f04-4f21-460a-9594-aefcdf3dadbd	formatted	user.attribute.formatted
eb697f04-4f21-460a-9594-aefcdf3dadbd	country	user.attribute.country
eb697f04-4f21-460a-9594-aefcdf3dadbd	postal_code	user.attribute.postal_code
eb697f04-4f21-460a-9594-aefcdf3dadbd	true	userinfo.token.claim
eb697f04-4f21-460a-9594-aefcdf3dadbd	street	user.attribute.street
eb697f04-4f21-460a-9594-aefcdf3dadbd	true	id.token.claim
eb697f04-4f21-460a-9594-aefcdf3dadbd	region	user.attribute.region
eb697f04-4f21-460a-9594-aefcdf3dadbd	true	access.token.claim
eb697f04-4f21-460a-9594-aefcdf3dadbd	locality	user.attribute.locality
13c2d730-0ae1-4222-b51f-e94b158807c3	true	userinfo.token.claim
13c2d730-0ae1-4222-b51f-e94b158807c3	phoneNumber	user.attribute
13c2d730-0ae1-4222-b51f-e94b158807c3	true	id.token.claim
13c2d730-0ae1-4222-b51f-e94b158807c3	true	access.token.claim
13c2d730-0ae1-4222-b51f-e94b158807c3	phone_number	claim.name
13c2d730-0ae1-4222-b51f-e94b158807c3	String	jsonType.label
5eac9cfa-b7a4-4c46-8e3c-e5ebe1e7fa12	true	userinfo.token.claim
5eac9cfa-b7a4-4c46-8e3c-e5ebe1e7fa12	phoneNumberVerified	user.attribute
5eac9cfa-b7a4-4c46-8e3c-e5ebe1e7fa12	true	id.token.claim
5eac9cfa-b7a4-4c46-8e3c-e5ebe1e7fa12	true	access.token.claim
5eac9cfa-b7a4-4c46-8e3c-e5ebe1e7fa12	phone_number_verified	claim.name
5eac9cfa-b7a4-4c46-8e3c-e5ebe1e7fa12	boolean	jsonType.label
0a7f0511-a05e-42c4-968b-fbd10ccf1f8c	true	multivalued
0a7f0511-a05e-42c4-968b-fbd10ccf1f8c	foo	user.attribute
0a7f0511-a05e-42c4-968b-fbd10ccf1f8c	true	access.token.claim
0a7f0511-a05e-42c4-968b-fbd10ccf1f8c	resource_access.${client_id}.roles	claim.name
0a7f0511-a05e-42c4-968b-fbd10ccf1f8c	String	jsonType.label
6024a670-7508-4a69-b2bf-31fcd1efd73b	true	multivalued
6024a670-7508-4a69-b2bf-31fcd1efd73b	foo	user.attribute
6024a670-7508-4a69-b2bf-31fcd1efd73b	true	access.token.claim
6024a670-7508-4a69-b2bf-31fcd1efd73b	realm_access.roles	claim.name
6024a670-7508-4a69-b2bf-31fcd1efd73b	String	jsonType.label
0c1fdd36-4192-47f7-9fc7-766b6c56794c	true	multivalued
0c1fdd36-4192-47f7-9fc7-766b6c56794c	foo	user.attribute
0c1fdd36-4192-47f7-9fc7-766b6c56794c	true	id.token.claim
0c1fdd36-4192-47f7-9fc7-766b6c56794c	true	access.token.claim
0c1fdd36-4192-47f7-9fc7-766b6c56794c	groups	claim.name
0c1fdd36-4192-47f7-9fc7-766b6c56794c	String	jsonType.label
23060161-4b2b-4551-9c1d-f2f4d58a105e	true	userinfo.token.claim
23060161-4b2b-4551-9c1d-f2f4d58a105e	username	user.attribute
23060161-4b2b-4551-9c1d-f2f4d58a105e	true	id.token.claim
23060161-4b2b-4551-9c1d-f2f4d58a105e	true	access.token.claim
23060161-4b2b-4551-9c1d-f2f4d58a105e	upn	claim.name
23060161-4b2b-4551-9c1d-f2f4d58a105e	String	jsonType.label
bc4d7b24-40a5-4974-a286-4a0a03c9b440	true	id.token.claim
bc4d7b24-40a5-4974-a286-4a0a03c9b440	true	access.token.claim
78d1eecf-e1d8-4af8-b219-78f9c454dc88	false	single
78d1eecf-e1d8-4af8-b219-78f9c454dc88	Basic	attribute.nameformat
78d1eecf-e1d8-4af8-b219-78f9c454dc88	Role	attribute.name
0cf409d9-5dfd-4b03-b12b-da3439ce0019	true	userinfo.token.claim
0cf409d9-5dfd-4b03-b12b-da3439ce0019	username	user.attribute
0cf409d9-5dfd-4b03-b12b-da3439ce0019	true	id.token.claim
0cf409d9-5dfd-4b03-b12b-da3439ce0019	true	access.token.claim
0cf409d9-5dfd-4b03-b12b-da3439ce0019	preferred_username	claim.name
0cf409d9-5dfd-4b03-b12b-da3439ce0019	String	jsonType.label
401d99a0-2223-4fca-a249-7a6fcadb91b4	true	userinfo.token.claim
401d99a0-2223-4fca-a249-7a6fcadb91b4	true	id.token.claim
401d99a0-2223-4fca-a249-7a6fcadb91b4	true	access.token.claim
6525686a-b022-4440-b92e-9a83666c5cfd	true	userinfo.token.claim
6525686a-b022-4440-b92e-9a83666c5cfd	middleName	user.attribute
6525686a-b022-4440-b92e-9a83666c5cfd	true	id.token.claim
6525686a-b022-4440-b92e-9a83666c5cfd	true	access.token.claim
6525686a-b022-4440-b92e-9a83666c5cfd	middle_name	claim.name
6525686a-b022-4440-b92e-9a83666c5cfd	String	jsonType.label
66d112ce-e8bb-48ab-9316-ae2283b136c5	true	userinfo.token.claim
66d112ce-e8bb-48ab-9316-ae2283b136c5	picture	user.attribute
66d112ce-e8bb-48ab-9316-ae2283b136c5	true	id.token.claim
66d112ce-e8bb-48ab-9316-ae2283b136c5	true	access.token.claim
66d112ce-e8bb-48ab-9316-ae2283b136c5	picture	claim.name
66d112ce-e8bb-48ab-9316-ae2283b136c5	String	jsonType.label
856a1e8f-7893-41b9-8c27-a5c509e713a1	true	userinfo.token.claim
856a1e8f-7893-41b9-8c27-a5c509e713a1	updatedAt	user.attribute
856a1e8f-7893-41b9-8c27-a5c509e713a1	true	id.token.claim
856a1e8f-7893-41b9-8c27-a5c509e713a1	true	access.token.claim
856a1e8f-7893-41b9-8c27-a5c509e713a1	updated_at	claim.name
856a1e8f-7893-41b9-8c27-a5c509e713a1	long	jsonType.label
88cbb353-04c0-4c29-a657-90ed106ca10e	true	userinfo.token.claim
88cbb353-04c0-4c29-a657-90ed106ca10e	firstName	user.attribute
88cbb353-04c0-4c29-a657-90ed106ca10e	true	id.token.claim
88cbb353-04c0-4c29-a657-90ed106ca10e	true	access.token.claim
88cbb353-04c0-4c29-a657-90ed106ca10e	given_name	claim.name
88cbb353-04c0-4c29-a657-90ed106ca10e	String	jsonType.label
9315b0b5-8187-48f7-bd6c-26499e63f086	true	userinfo.token.claim
9315b0b5-8187-48f7-bd6c-26499e63f086	profile	user.attribute
9315b0b5-8187-48f7-bd6c-26499e63f086	true	id.token.claim
9315b0b5-8187-48f7-bd6c-26499e63f086	true	access.token.claim
9315b0b5-8187-48f7-bd6c-26499e63f086	profile	claim.name
9315b0b5-8187-48f7-bd6c-26499e63f086	String	jsonType.label
933ae076-bfba-4735-83a3-04da296892f4	true	userinfo.token.claim
933ae076-bfba-4735-83a3-04da296892f4	nickname	user.attribute
933ae076-bfba-4735-83a3-04da296892f4	true	id.token.claim
933ae076-bfba-4735-83a3-04da296892f4	true	access.token.claim
933ae076-bfba-4735-83a3-04da296892f4	nickname	claim.name
933ae076-bfba-4735-83a3-04da296892f4	String	jsonType.label
bb85e27d-0e8d-486c-b076-408952952ca4	true	userinfo.token.claim
bb85e27d-0e8d-486c-b076-408952952ca4	lastName	user.attribute
bb85e27d-0e8d-486c-b076-408952952ca4	true	id.token.claim
bb85e27d-0e8d-486c-b076-408952952ca4	true	access.token.claim
bb85e27d-0e8d-486c-b076-408952952ca4	family_name	claim.name
bb85e27d-0e8d-486c-b076-408952952ca4	String	jsonType.label
be9c12f0-dbdb-489d-8b57-746998252fb8	true	userinfo.token.claim
be9c12f0-dbdb-489d-8b57-746998252fb8	locale	user.attribute
be9c12f0-dbdb-489d-8b57-746998252fb8	true	id.token.claim
be9c12f0-dbdb-489d-8b57-746998252fb8	true	access.token.claim
be9c12f0-dbdb-489d-8b57-746998252fb8	locale	claim.name
be9c12f0-dbdb-489d-8b57-746998252fb8	String	jsonType.label
ca1d30f2-d081-4e03-8134-f265c6d11c6a	true	userinfo.token.claim
ca1d30f2-d081-4e03-8134-f265c6d11c6a	gender	user.attribute
ca1d30f2-d081-4e03-8134-f265c6d11c6a	true	id.token.claim
ca1d30f2-d081-4e03-8134-f265c6d11c6a	true	access.token.claim
ca1d30f2-d081-4e03-8134-f265c6d11c6a	gender	claim.name
ca1d30f2-d081-4e03-8134-f265c6d11c6a	String	jsonType.label
cdb8f8a0-0194-42ad-9f6f-4878f9f7aa98	true	userinfo.token.claim
cdb8f8a0-0194-42ad-9f6f-4878f9f7aa98	zoneinfo	user.attribute
cdb8f8a0-0194-42ad-9f6f-4878f9f7aa98	true	id.token.claim
cdb8f8a0-0194-42ad-9f6f-4878f9f7aa98	true	access.token.claim
cdb8f8a0-0194-42ad-9f6f-4878f9f7aa98	zoneinfo	claim.name
cdb8f8a0-0194-42ad-9f6f-4878f9f7aa98	String	jsonType.label
f3428623-4d17-4746-9e93-5062f355f7c3	true	userinfo.token.claim
f3428623-4d17-4746-9e93-5062f355f7c3	website	user.attribute
f3428623-4d17-4746-9e93-5062f355f7c3	true	id.token.claim
f3428623-4d17-4746-9e93-5062f355f7c3	true	access.token.claim
f3428623-4d17-4746-9e93-5062f355f7c3	website	claim.name
f3428623-4d17-4746-9e93-5062f355f7c3	String	jsonType.label
fd5a6c0a-8d42-4902-afe5-1a87e8106f50	true	userinfo.token.claim
fd5a6c0a-8d42-4902-afe5-1a87e8106f50	birthdate	user.attribute
fd5a6c0a-8d42-4902-afe5-1a87e8106f50	true	id.token.claim
fd5a6c0a-8d42-4902-afe5-1a87e8106f50	true	access.token.claim
fd5a6c0a-8d42-4902-afe5-1a87e8106f50	birthdate	claim.name
fd5a6c0a-8d42-4902-afe5-1a87e8106f50	String	jsonType.label
2e85cf3a-2c0d-4fe9-b919-e4dabf44be5f	true	userinfo.token.claim
2e85cf3a-2c0d-4fe9-b919-e4dabf44be5f	email	user.attribute
2e85cf3a-2c0d-4fe9-b919-e4dabf44be5f	true	id.token.claim
2e85cf3a-2c0d-4fe9-b919-e4dabf44be5f	true	access.token.claim
2e85cf3a-2c0d-4fe9-b919-e4dabf44be5f	email	claim.name
2e85cf3a-2c0d-4fe9-b919-e4dabf44be5f	String	jsonType.label
8474b90a-b251-4097-aab8-c5351f1997d8	true	userinfo.token.claim
8474b90a-b251-4097-aab8-c5351f1997d8	emailVerified	user.attribute
8474b90a-b251-4097-aab8-c5351f1997d8	true	id.token.claim
8474b90a-b251-4097-aab8-c5351f1997d8	true	access.token.claim
8474b90a-b251-4097-aab8-c5351f1997d8	email_verified	claim.name
8474b90a-b251-4097-aab8-c5351f1997d8	boolean	jsonType.label
e95c5176-de2a-4cec-95c2-35608a9614fd	formatted	user.attribute.formatted
e95c5176-de2a-4cec-95c2-35608a9614fd	country	user.attribute.country
e95c5176-de2a-4cec-95c2-35608a9614fd	postal_code	user.attribute.postal_code
e95c5176-de2a-4cec-95c2-35608a9614fd	true	userinfo.token.claim
e95c5176-de2a-4cec-95c2-35608a9614fd	street	user.attribute.street
e95c5176-de2a-4cec-95c2-35608a9614fd	true	id.token.claim
e95c5176-de2a-4cec-95c2-35608a9614fd	region	user.attribute.region
e95c5176-de2a-4cec-95c2-35608a9614fd	true	access.token.claim
e95c5176-de2a-4cec-95c2-35608a9614fd	locality	user.attribute.locality
22e5fe50-3f80-44c1-b9aa-2819f14a6ab9	true	userinfo.token.claim
22e5fe50-3f80-44c1-b9aa-2819f14a6ab9	phoneNumber	user.attribute
22e5fe50-3f80-44c1-b9aa-2819f14a6ab9	true	id.token.claim
22e5fe50-3f80-44c1-b9aa-2819f14a6ab9	true	access.token.claim
22e5fe50-3f80-44c1-b9aa-2819f14a6ab9	phone_number	claim.name
22e5fe50-3f80-44c1-b9aa-2819f14a6ab9	String	jsonType.label
84cdebf9-8d78-4d98-b28a-21c1b735f645	true	userinfo.token.claim
84cdebf9-8d78-4d98-b28a-21c1b735f645	phoneNumberVerified	user.attribute
84cdebf9-8d78-4d98-b28a-21c1b735f645	true	id.token.claim
84cdebf9-8d78-4d98-b28a-21c1b735f645	true	access.token.claim
84cdebf9-8d78-4d98-b28a-21c1b735f645	phone_number_verified	claim.name
84cdebf9-8d78-4d98-b28a-21c1b735f645	boolean	jsonType.label
55ba3e4d-7084-4275-800a-e49bb29f67f7	true	multivalued
55ba3e4d-7084-4275-800a-e49bb29f67f7	foo	user.attribute
55ba3e4d-7084-4275-800a-e49bb29f67f7	true	access.token.claim
55ba3e4d-7084-4275-800a-e49bb29f67f7	resource_access.${client_id}.roles	claim.name
55ba3e4d-7084-4275-800a-e49bb29f67f7	String	jsonType.label
f26600a3-ef47-4668-aca7-9f537f89ef0b	true	multivalued
f26600a3-ef47-4668-aca7-9f537f89ef0b	foo	user.attribute
f26600a3-ef47-4668-aca7-9f537f89ef0b	true	access.token.claim
f26600a3-ef47-4668-aca7-9f537f89ef0b	realm_access.roles	claim.name
f26600a3-ef47-4668-aca7-9f537f89ef0b	String	jsonType.label
1b1a8b99-1e1f-4420-82df-f04db390de1f	true	multivalued
1b1a8b99-1e1f-4420-82df-f04db390de1f	foo	user.attribute
1b1a8b99-1e1f-4420-82df-f04db390de1f	true	id.token.claim
1b1a8b99-1e1f-4420-82df-f04db390de1f	true	access.token.claim
1b1a8b99-1e1f-4420-82df-f04db390de1f	groups	claim.name
1b1a8b99-1e1f-4420-82df-f04db390de1f	String	jsonType.label
52fca26e-3c2d-443c-b73d-f2aaaeb57f4f	true	userinfo.token.claim
52fca26e-3c2d-443c-b73d-f2aaaeb57f4f	username	user.attribute
52fca26e-3c2d-443c-b73d-f2aaaeb57f4f	true	id.token.claim
52fca26e-3c2d-443c-b73d-f2aaaeb57f4f	true	access.token.claim
52fca26e-3c2d-443c-b73d-f2aaaeb57f4f	upn	claim.name
52fca26e-3c2d-443c-b73d-f2aaaeb57f4f	String	jsonType.label
d1561e2b-3c49-4436-a009-05cbe0ce2027	true	id.token.claim
d1561e2b-3c49-4436-a009-05cbe0ce2027	true	access.token.claim
aa8a22d3-b8ec-4bd5-a83b-48ba777299d7	true	userinfo.token.claim
aa8a22d3-b8ec-4bd5-a83b-48ba777299d7	locale	user.attribute
aa8a22d3-b8ec-4bd5-a83b-48ba777299d7	true	id.token.claim
aa8a22d3-b8ec-4bd5-a83b-48ba777299d7	true	access.token.claim
aa8a22d3-b8ec-4bd5-a83b-48ba777299d7	locale	claim.name
aa8a22d3-b8ec-4bd5-a83b-48ba777299d7	String	jsonType.label
7d2e1477-71c7-4266-a8a3-d499f15a7d36	hardcoded_value	claim.value
7d2e1477-71c7-4266-a8a3-d499f15a7d36	true	userinfo.token.claim
7d2e1477-71c7-4266-a8a3-d499f15a7d36	true	id.token.claim
7d2e1477-71c7-4266-a8a3-d499f15a7d36	true	access.token.claim
7d2e1477-71c7-4266-a8a3-d499f15a7d36	my_hardcoded_claim	claim.name
7d2e1477-71c7-4266-a8a3-d499f15a7d36	true	access.tokenResponse.claim
\.


--
-- Data for Name: realm; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.realm (id, access_code_lifespan, user_action_lifespan, access_token_lifespan, account_theme, admin_theme, email_theme, enabled, events_enabled, events_expiration, login_theme, name, not_before, password_policy, registration_allowed, remember_me, reset_password_allowed, social, ssl_required, sso_idle_timeout, sso_max_lifespan, update_profile_on_soc_login, verify_email, master_admin_client, login_lifespan, internationalization_enabled, default_locale, reg_email_as_username, admin_events_enabled, admin_events_details_enabled, edit_username_allowed, otp_policy_counter, otp_policy_window, otp_policy_period, otp_policy_digits, otp_policy_alg, otp_policy_type, browser_flow, registration_flow, direct_grant_flow, reset_credentials_flow, client_auth_flow, offline_session_idle_timeout, revoke_refresh_token, access_token_life_implicit, login_with_email_allowed, duplicate_emails_allowed, docker_auth_flow, refresh_token_max_reuse, allow_user_managed_access, sso_max_lifespan_remember_me, sso_idle_timeout_remember_me, default_role) FROM stdin;
ba1a6f7d-badd-4ac5-9ce3-3a5dc0dd1d0b	60	300	300	\N	\N	\N	t	f	0	\N	poc-realm	0	\N	t	t	t	f	EXTERNAL	1800	36000	f	f	d3a1c55d-68b9-41f2-ad98-a8bcb669d6aa	1800	f	\N	f	f	f	f	0	1	30	6	HmacSHA1	totp	e3c72776-738f-4a50-8b65-15737aeb31cd	8b44a050-5ec9-4e52-b6a3-89fd59bdeb91	00f7b56a-1e4b-445a-a424-b7706190f506	fcb6b793-200e-492a-a09b-f3ea026f3a6a	903d0900-b5b6-4055-8075-957d04292a1b	2592000	f	900	t	f	e3935ad1-5899-48a5-be90-c4956388f55e	0	f	0	0	e8eb2cf0-e9ff-4e80-ae1f-3dca2cd64a9c
d86ec37e-5c02-4219-bb0d-99cb545457ff	60	300	60	\N	\N	\N	t	f	0	\N	master	0	\N	f	f	f	f	EXTERNAL	1800	36000	f	f	5debe463-9857-47f1-8f77-552084601bcb	1800	f	\N	f	f	f	f	0	1	30	6	HmacSHA1	totp	53d7b7d6-2888-4ee8-8819-2f54318a7cf3	e624c028-7185-4249-921c-fc1ab3a68189	e8462dba-6e4f-4785-8ffb-002f86b7c0f5	fbd4f9f6-c609-49ff-951e-07907ac1cec2	5fd90bc0-23c2-4127-b579-45d454887eee	2592000	f	900	t	f	0d92b695-e6a8-4438-8cb9-f1def22bded4	0	f	0	0	e435fff0-1799-4855-95c6-7e13216cae6b
\.


--
-- Data for Name: realm_attribute; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.realm_attribute (name, realm_id, value) FROM stdin;
_browser_header.contentSecurityPolicyReportOnly	d86ec37e-5c02-4219-bb0d-99cb545457ff	
_browser_header.xContentTypeOptions	d86ec37e-5c02-4219-bb0d-99cb545457ff	nosniff
_browser_header.xRobotsTag	d86ec37e-5c02-4219-bb0d-99cb545457ff	none
_browser_header.xFrameOptions	d86ec37e-5c02-4219-bb0d-99cb545457ff	SAMEORIGIN
_browser_header.contentSecurityPolicy	d86ec37e-5c02-4219-bb0d-99cb545457ff	frame-src 'self'; frame-ancestors 'self'; object-src 'none';
_browser_header.xXSSProtection	d86ec37e-5c02-4219-bb0d-99cb545457ff	1; mode=block
_browser_header.strictTransportSecurity	d86ec37e-5c02-4219-bb0d-99cb545457ff	max-age=31536000; includeSubDomains
bruteForceProtected	d86ec37e-5c02-4219-bb0d-99cb545457ff	false
permanentLockout	d86ec37e-5c02-4219-bb0d-99cb545457ff	false
maxFailureWaitSeconds	d86ec37e-5c02-4219-bb0d-99cb545457ff	900
minimumQuickLoginWaitSeconds	d86ec37e-5c02-4219-bb0d-99cb545457ff	60
waitIncrementSeconds	d86ec37e-5c02-4219-bb0d-99cb545457ff	60
quickLoginCheckMilliSeconds	d86ec37e-5c02-4219-bb0d-99cb545457ff	1000
maxDeltaTimeSeconds	d86ec37e-5c02-4219-bb0d-99cb545457ff	43200
failureFactor	d86ec37e-5c02-4219-bb0d-99cb545457ff	30
displayName	d86ec37e-5c02-4219-bb0d-99cb545457ff	Keycloak
displayNameHtml	d86ec37e-5c02-4219-bb0d-99cb545457ff	<div class="kc-logo-text"><span>Keycloak</span></div>
defaultSignatureAlgorithm	d86ec37e-5c02-4219-bb0d-99cb545457ff	RS256
offlineSessionMaxLifespanEnabled	d86ec37e-5c02-4219-bb0d-99cb545457ff	false
offlineSessionMaxLifespan	d86ec37e-5c02-4219-bb0d-99cb545457ff	5184000
oauth2DeviceCodeLifespan	ba1a6f7d-badd-4ac5-9ce3-3a5dc0dd1d0b	600
oauth2DevicePollingInterval	ba1a6f7d-badd-4ac5-9ce3-3a5dc0dd1d0b	5
cibaBackchannelTokenDeliveryMode	ba1a6f7d-badd-4ac5-9ce3-3a5dc0dd1d0b	poll
cibaExpiresIn	ba1a6f7d-badd-4ac5-9ce3-3a5dc0dd1d0b	120
cibaInterval	ba1a6f7d-badd-4ac5-9ce3-3a5dc0dd1d0b	5
cibaAuthRequestedUserHint	ba1a6f7d-badd-4ac5-9ce3-3a5dc0dd1d0b	login_hint
parRequestUriLifespan	ba1a6f7d-badd-4ac5-9ce3-3a5dc0dd1d0b	60
clientSessionIdleTimeout	ba1a6f7d-badd-4ac5-9ce3-3a5dc0dd1d0b	0
clientSessionMaxLifespan	ba1a6f7d-badd-4ac5-9ce3-3a5dc0dd1d0b	0
clientOfflineSessionIdleTimeout	ba1a6f7d-badd-4ac5-9ce3-3a5dc0dd1d0b	0
clientOfflineSessionMaxLifespan	ba1a6f7d-badd-4ac5-9ce3-3a5dc0dd1d0b	0
bruteForceProtected	ba1a6f7d-badd-4ac5-9ce3-3a5dc0dd1d0b	false
permanentLockout	ba1a6f7d-badd-4ac5-9ce3-3a5dc0dd1d0b	false
maxFailureWaitSeconds	ba1a6f7d-badd-4ac5-9ce3-3a5dc0dd1d0b	900
minimumQuickLoginWaitSeconds	ba1a6f7d-badd-4ac5-9ce3-3a5dc0dd1d0b	60
waitIncrementSeconds	ba1a6f7d-badd-4ac5-9ce3-3a5dc0dd1d0b	60
quickLoginCheckMilliSeconds	ba1a6f7d-badd-4ac5-9ce3-3a5dc0dd1d0b	1000
maxDeltaTimeSeconds	ba1a6f7d-badd-4ac5-9ce3-3a5dc0dd1d0b	43200
failureFactor	ba1a6f7d-badd-4ac5-9ce3-3a5dc0dd1d0b	30
actionTokenGeneratedByAdminLifespan	ba1a6f7d-badd-4ac5-9ce3-3a5dc0dd1d0b	43200
actionTokenGeneratedByUserLifespan	ba1a6f7d-badd-4ac5-9ce3-3a5dc0dd1d0b	300
defaultSignatureAlgorithm	ba1a6f7d-badd-4ac5-9ce3-3a5dc0dd1d0b	RS256
offlineSessionMaxLifespanEnabled	ba1a6f7d-badd-4ac5-9ce3-3a5dc0dd1d0b	false
offlineSessionMaxLifespan	ba1a6f7d-badd-4ac5-9ce3-3a5dc0dd1d0b	5184000
webAuthnPolicyRpEntityName	ba1a6f7d-badd-4ac5-9ce3-3a5dc0dd1d0b	keycloak
webAuthnPolicySignatureAlgorithms	ba1a6f7d-badd-4ac5-9ce3-3a5dc0dd1d0b	ES256
webAuthnPolicyRpId	ba1a6f7d-badd-4ac5-9ce3-3a5dc0dd1d0b	
webAuthnPolicyAttestationConveyancePreference	ba1a6f7d-badd-4ac5-9ce3-3a5dc0dd1d0b	not specified
webAuthnPolicyAuthenticatorAttachment	ba1a6f7d-badd-4ac5-9ce3-3a5dc0dd1d0b	not specified
webAuthnPolicyRequireResidentKey	ba1a6f7d-badd-4ac5-9ce3-3a5dc0dd1d0b	not specified
webAuthnPolicyUserVerificationRequirement	ba1a6f7d-badd-4ac5-9ce3-3a5dc0dd1d0b	not specified
webAuthnPolicyCreateTimeout	ba1a6f7d-badd-4ac5-9ce3-3a5dc0dd1d0b	0
webAuthnPolicyAvoidSameAuthenticatorRegister	ba1a6f7d-badd-4ac5-9ce3-3a5dc0dd1d0b	false
webAuthnPolicyRpEntityNamePasswordless	ba1a6f7d-badd-4ac5-9ce3-3a5dc0dd1d0b	keycloak
webAuthnPolicySignatureAlgorithmsPasswordless	ba1a6f7d-badd-4ac5-9ce3-3a5dc0dd1d0b	ES256
webAuthnPolicyRpIdPasswordless	ba1a6f7d-badd-4ac5-9ce3-3a5dc0dd1d0b	
webAuthnPolicyAttestationConveyancePreferencePasswordless	ba1a6f7d-badd-4ac5-9ce3-3a5dc0dd1d0b	not specified
webAuthnPolicyAuthenticatorAttachmentPasswordless	ba1a6f7d-badd-4ac5-9ce3-3a5dc0dd1d0b	not specified
webAuthnPolicyRequireResidentKeyPasswordless	ba1a6f7d-badd-4ac5-9ce3-3a5dc0dd1d0b	not specified
webAuthnPolicyUserVerificationRequirementPasswordless	ba1a6f7d-badd-4ac5-9ce3-3a5dc0dd1d0b	not specified
webAuthnPolicyCreateTimeoutPasswordless	ba1a6f7d-badd-4ac5-9ce3-3a5dc0dd1d0b	0
webAuthnPolicyAvoidSameAuthenticatorRegisterPasswordless	ba1a6f7d-badd-4ac5-9ce3-3a5dc0dd1d0b	false
client-policies.profiles	ba1a6f7d-badd-4ac5-9ce3-3a5dc0dd1d0b	{"profiles":[]}
client-policies.policies	ba1a6f7d-badd-4ac5-9ce3-3a5dc0dd1d0b	{"policies":[]}
_browser_header.contentSecurityPolicyReportOnly	ba1a6f7d-badd-4ac5-9ce3-3a5dc0dd1d0b	
_browser_header.xContentTypeOptions	ba1a6f7d-badd-4ac5-9ce3-3a5dc0dd1d0b	nosniff
_browser_header.xRobotsTag	ba1a6f7d-badd-4ac5-9ce3-3a5dc0dd1d0b	none
_browser_header.xFrameOptions	ba1a6f7d-badd-4ac5-9ce3-3a5dc0dd1d0b	SAMEORIGIN
_browser_header.contentSecurityPolicy	ba1a6f7d-badd-4ac5-9ce3-3a5dc0dd1d0b	frame-src 'self'; frame-ancestors 'self'; object-src 'none';
_browser_header.xXSSProtection	ba1a6f7d-badd-4ac5-9ce3-3a5dc0dd1d0b	1; mode=block
_browser_header.strictTransportSecurity	ba1a6f7d-badd-4ac5-9ce3-3a5dc0dd1d0b	max-age=31536000; includeSubDomains
\.


--
-- Data for Name: realm_default_groups; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.realm_default_groups (realm_id, group_id) FROM stdin;
\.


--
-- Data for Name: realm_enabled_event_types; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.realm_enabled_event_types (realm_id, value) FROM stdin;
\.


--
-- Data for Name: realm_events_listeners; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.realm_events_listeners (realm_id, value) FROM stdin;
d86ec37e-5c02-4219-bb0d-99cb545457ff	jboss-logging
ba1a6f7d-badd-4ac5-9ce3-3a5dc0dd1d0b	jboss-logging
\.


--
-- Data for Name: realm_localizations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.realm_localizations (realm_id, locale, texts) FROM stdin;
\.


--
-- Data for Name: realm_required_credential; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.realm_required_credential (type, form_label, input, secret, realm_id) FROM stdin;
password	password	t	t	d86ec37e-5c02-4219-bb0d-99cb545457ff
password	password	t	t	ba1a6f7d-badd-4ac5-9ce3-3a5dc0dd1d0b
\.


--
-- Data for Name: realm_smtp_config; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.realm_smtp_config (realm_id, value, name) FROM stdin;
\.


--
-- Data for Name: realm_supported_locales; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.realm_supported_locales (realm_id, value) FROM stdin;
\.


--
-- Data for Name: redirect_uris; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.redirect_uris (client_id, value) FROM stdin;
2d9b5f65-2907-4e43-b54d-b5f405769ed0	/realms/master/account/*
b0c07851-5a13-4c04-8167-eb74fe4bf073	/realms/master/account/*
e12365ba-b577-4fb1-acec-d10e2a6fd9a0	/admin/master/console/*
6899b2e9-8cdb-41ad-b45f-c4a40fd40621	/realms/poc-realm/account/*
7a7e6753-8234-49ad-8473-0425c343131c	/realms/poc-realm/account/*
33b7bec8-88a8-4526-81f1-4c14bc121bf2	/admin/poc-realm/console/*
1ce59c97-2365-4484-80b6-3c471172f3be	
1ce59c97-2365-4484-80b6-3c471172f3be	*
\.


--
-- Data for Name: required_action_config; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.required_action_config (required_action_id, value, name) FROM stdin;
\.


--
-- Data for Name: required_action_provider; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.required_action_provider (id, alias, name, realm_id, enabled, default_action, provider_id, priority) FROM stdin;
5b54d800-7c94-4a7d-89fc-6db5382c8024	VERIFY_EMAIL	Verify Email	d86ec37e-5c02-4219-bb0d-99cb545457ff	t	f	VERIFY_EMAIL	50
838a1ffb-7584-432e-afd7-2c4422fec7ae	UPDATE_PROFILE	Update Profile	d86ec37e-5c02-4219-bb0d-99cb545457ff	t	f	UPDATE_PROFILE	40
9672aeb6-a396-44b8-950e-2b64b659a6de	CONFIGURE_TOTP	Configure OTP	d86ec37e-5c02-4219-bb0d-99cb545457ff	t	f	CONFIGURE_TOTP	10
9cd2e7d1-4821-4c2c-b885-9cdd1151f25a	UPDATE_PASSWORD	Update Password	d86ec37e-5c02-4219-bb0d-99cb545457ff	t	f	UPDATE_PASSWORD	30
41fcc20e-e1fa-42d5-b44b-72774c471755	terms_and_conditions	Terms and Conditions	d86ec37e-5c02-4219-bb0d-99cb545457ff	f	f	terms_and_conditions	20
c976a20d-3cfd-4b32-ad62-1a1b6208f2cd	update_user_locale	Update User Locale	d86ec37e-5c02-4219-bb0d-99cb545457ff	t	f	update_user_locale	1000
a18d16ed-995b-4fd0-ae8c-84746204199b	delete_account	Delete Account	d86ec37e-5c02-4219-bb0d-99cb545457ff	f	f	delete_account	60
bd910444-6451-4a91-ac52-9c1523610025	webauthn-register	Webauthn Register	d86ec37e-5c02-4219-bb0d-99cb545457ff	t	f	webauthn-register	70
5b34acf8-5ce0-494f-956a-52a81c3b0a43	webauthn-register-passwordless	Webauthn Register Passwordless	d86ec37e-5c02-4219-bb0d-99cb545457ff	t	f	webauthn-register-passwordless	80
83a1d06e-12c4-4325-959f-99451d334327	VERIFY_EMAIL	Verify Email	ba1a6f7d-badd-4ac5-9ce3-3a5dc0dd1d0b	t	f	VERIFY_EMAIL	50
e55aee5d-d9e2-4fa8-a4de-415358bf77c8	UPDATE_PROFILE	Update Profile	ba1a6f7d-badd-4ac5-9ce3-3a5dc0dd1d0b	t	f	UPDATE_PROFILE	40
073d65d8-191f-4685-b24b-9961bdacba96	CONFIGURE_TOTP	Configure OTP	ba1a6f7d-badd-4ac5-9ce3-3a5dc0dd1d0b	t	f	CONFIGURE_TOTP	10
dbbb187d-95b3-4dae-aabb-55eafd1920b6	UPDATE_PASSWORD	Update Password	ba1a6f7d-badd-4ac5-9ce3-3a5dc0dd1d0b	t	f	UPDATE_PASSWORD	30
b91c1bbe-68d6-4306-a670-aa924db7d007	terms_and_conditions	Terms and Conditions	ba1a6f7d-badd-4ac5-9ce3-3a5dc0dd1d0b	f	f	terms_and_conditions	20
e1ab630c-c66c-4814-b5b2-3cb23578486f	update_user_locale	Update User Locale	ba1a6f7d-badd-4ac5-9ce3-3a5dc0dd1d0b	t	f	update_user_locale	1000
21f86f08-3c7d-47ae-8424-ae450f441808	delete_account	Delete Account	ba1a6f7d-badd-4ac5-9ce3-3a5dc0dd1d0b	f	f	delete_account	60
9b15be67-bc63-48aa-bc74-82e3dbe14644	webauthn-register	Webauthn Register	ba1a6f7d-badd-4ac5-9ce3-3a5dc0dd1d0b	t	f	webauthn-register	70
9ba4b2af-2731-454e-a528-3cef3c5d1d69	webauthn-register-passwordless	Webauthn Register Passwordless	ba1a6f7d-badd-4ac5-9ce3-3a5dc0dd1d0b	t	f	webauthn-register-passwordless	80
\.


--
-- Data for Name: resource_attribute; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.resource_attribute (id, name, value, resource_id) FROM stdin;
\.


--
-- Data for Name: resource_policy; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.resource_policy (resource_id, policy_id) FROM stdin;
\.


--
-- Data for Name: resource_scope; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.resource_scope (resource_id, scope_id) FROM stdin;
\.


--
-- Data for Name: resource_server; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.resource_server (id, allow_rs_remote_mgmt, policy_enforce_mode, decision_strategy) FROM stdin;
\.


--
-- Data for Name: resource_server_perm_ticket; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.resource_server_perm_ticket (id, owner, requester, created_timestamp, granted_timestamp, resource_id, scope_id, resource_server_id, policy_id) FROM stdin;
\.


--
-- Data for Name: resource_server_policy; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.resource_server_policy (id, name, description, type, decision_strategy, logic, resource_server_id, owner) FROM stdin;
\.


--
-- Data for Name: resource_server_resource; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.resource_server_resource (id, name, type, icon_uri, owner, resource_server_id, owner_managed_access, display_name) FROM stdin;
\.


--
-- Data for Name: resource_server_scope; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.resource_server_scope (id, name, icon_uri, resource_server_id, display_name) FROM stdin;
\.


--
-- Data for Name: resource_uris; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.resource_uris (resource_id, value) FROM stdin;
\.


--
-- Data for Name: role_attribute; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.role_attribute (id, role_id, name, value) FROM stdin;
\.


--
-- Data for Name: scope_mapping; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.scope_mapping (client_id, role_id) FROM stdin;
b0c07851-5a13-4c04-8167-eb74fe4bf073	65054880-79d1-453f-b115-9e79589dfea6
7a7e6753-8234-49ad-8473-0425c343131c	c759a209-0098-4865-a3cc-7415fe3ba038
\.


--
-- Data for Name: scope_policy; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.scope_policy (scope_id, policy_id) FROM stdin;
\.


--
-- Data for Name: user_attribute; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_attribute (name, value, user_id, id) FROM stdin;
\.


--
-- Data for Name: user_consent; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_consent (id, client_id, user_id, created_date, last_updated_date, client_storage_provider, external_client_id) FROM stdin;
\.


--
-- Data for Name: user_consent_client_scope; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_consent_client_scope (user_consent_id, scope_id) FROM stdin;
\.


--
-- Data for Name: user_entity; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_entity (id, email, email_constraint, email_verified, enabled, federation_link, first_name, last_name, realm_id, username, created_timestamp, service_account_client_link, not_before) FROM stdin;
733a0f8d-e2ac-4ef7-bfa4-0a017f3e73b1	\N	9523d5ab-07c0-4364-a993-9ebb20a862fd	f	t	\N	\N	\N	d86ec37e-5c02-4219-bb0d-99cb545457ff	admin	1661337657133	\N	0
215dbd9f-19e6-446b-ae84-226fc1942282	andres.garcia@fundacionctic.org	andres.garcia@fundacionctic.org	f	t	\N	Andres	Garcia Mangas	ba1a6f7d-badd-4ac5-9ce3-3a5dc0dd1d0b	andres.garcia	1661337866403	\N	0
\.


--
-- Data for Name: user_federation_config; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_federation_config (user_federation_provider_id, value, name) FROM stdin;
\.


--
-- Data for Name: user_federation_mapper; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_federation_mapper (id, name, federation_provider_id, federation_mapper_type, realm_id) FROM stdin;
\.


--
-- Data for Name: user_federation_mapper_config; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_federation_mapper_config (user_federation_mapper_id, value, name) FROM stdin;
\.


--
-- Data for Name: user_federation_provider; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_federation_provider (id, changed_sync_period, display_name, full_sync_period, last_sync, priority, provider_name, realm_id) FROM stdin;
\.


--
-- Data for Name: user_group_membership; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_group_membership (group_id, user_id) FROM stdin;
a3125c94-d207-4ca8-a0b9-160ca173792d	215dbd9f-19e6-446b-ae84-226fc1942282
\.


--
-- Data for Name: user_required_action; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_required_action (user_id, required_action) FROM stdin;
\.


--
-- Data for Name: user_role_mapping; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_role_mapping (role_id, user_id) FROM stdin;
e435fff0-1799-4855-95c6-7e13216cae6b	733a0f8d-e2ac-4ef7-bfa4-0a017f3e73b1
617981fb-0111-4a21-81f7-85d9474d1a2d	733a0f8d-e2ac-4ef7-bfa4-0a017f3e73b1
2f97a10b-f583-464c-a411-98aa393e4b7a	733a0f8d-e2ac-4ef7-bfa4-0a017f3e73b1
9236c4f8-b43e-4a62-8884-a7d4edca80fc	733a0f8d-e2ac-4ef7-bfa4-0a017f3e73b1
97a06a03-91cd-42f2-ab7a-98413a43a95d	733a0f8d-e2ac-4ef7-bfa4-0a017f3e73b1
1531b637-e05c-41ba-8330-6eb63098462d	733a0f8d-e2ac-4ef7-bfa4-0a017f3e73b1
ffb6f18d-1fe3-4c52-ae7d-daffc618c73c	733a0f8d-e2ac-4ef7-bfa4-0a017f3e73b1
ace72609-bcc8-4a5d-a087-1ebcad80e1ad	733a0f8d-e2ac-4ef7-bfa4-0a017f3e73b1
2bc0a4cb-4dfa-4e5c-b529-a4813cb409c4	733a0f8d-e2ac-4ef7-bfa4-0a017f3e73b1
b5835510-eb31-45d0-95a7-9a6304e8c4e8	733a0f8d-e2ac-4ef7-bfa4-0a017f3e73b1
3f58b0fb-e112-49b7-9234-c7d8cc858f0b	733a0f8d-e2ac-4ef7-bfa4-0a017f3e73b1
7a3d5de2-bf45-49b3-9895-17c1f49021ae	733a0f8d-e2ac-4ef7-bfa4-0a017f3e73b1
bdf61488-83d4-4827-b29c-76c7742f4ae8	733a0f8d-e2ac-4ef7-bfa4-0a017f3e73b1
208cd93f-5203-4317-aadd-01c04fdbb3cf	733a0f8d-e2ac-4ef7-bfa4-0a017f3e73b1
c041354d-8bda-465e-93af-cafab43337e4	733a0f8d-e2ac-4ef7-bfa4-0a017f3e73b1
6324675f-72a2-4c43-b07c-96065f63ca6e	733a0f8d-e2ac-4ef7-bfa4-0a017f3e73b1
00974d45-b847-4e7c-bf04-a3e6700eaa15	733a0f8d-e2ac-4ef7-bfa4-0a017f3e73b1
33bb94d4-a7c3-40f2-9607-2d1204d99268	733a0f8d-e2ac-4ef7-bfa4-0a017f3e73b1
ea48937f-7aaa-4650-a5f7-323c950737ee	733a0f8d-e2ac-4ef7-bfa4-0a017f3e73b1
e8eb2cf0-e9ff-4e80-ae1f-3dca2cd64a9c	215dbd9f-19e6-446b-ae84-226fc1942282
4cb40f78-fb1d-4f58-a692-596d237a6784	215dbd9f-19e6-446b-ae84-226fc1942282
\.


--
-- Data for Name: user_session; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_session (id, auth_method, ip_address, last_session_refresh, login_username, realm_id, remember_me, started, user_id, user_session_state, broker_session_id, broker_user_id) FROM stdin;
\.


--
-- Data for Name: user_session_note; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_session_note (user_session, name, value) FROM stdin;
\.


--
-- Data for Name: username_login_failure; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.username_login_failure (realm_id, username, failed_login_not_before, last_failure, last_ip_failure, num_failures) FROM stdin;
\.


--
-- Data for Name: web_origins; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.web_origins (client_id, value) FROM stdin;
e12365ba-b577-4fb1-acec-d10e2a6fd9a0	+
33b7bec8-88a8-4526-81f1-4c14bc121bf2	+
\.


--
-- Name: username_login_failure CONSTRAINT_17-2; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.username_login_failure
    ADD CONSTRAINT "CONSTRAINT_17-2" PRIMARY KEY (realm_id, username);


--
-- Name: keycloak_role UK_J3RWUVD56ONTGSUHOGM184WW2-2; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT "UK_J3RWUVD56ONTGSUHOGM184WW2-2" UNIQUE (name, client_realm_constraint);


--
-- Name: client_auth_flow_bindings c_cli_flow_bind; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_auth_flow_bindings
    ADD CONSTRAINT c_cli_flow_bind PRIMARY KEY (client_id, binding_name);


--
-- Name: client_scope_client c_cli_scope_bind; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_scope_client
    ADD CONSTRAINT c_cli_scope_bind PRIMARY KEY (client_id, scope_id);


--
-- Name: client_initial_access cnstr_client_init_acc_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_initial_access
    ADD CONSTRAINT cnstr_client_init_acc_pk PRIMARY KEY (id);


--
-- Name: realm_default_groups con_group_id_def_groups; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT con_group_id_def_groups UNIQUE (group_id);


--
-- Name: broker_link constr_broker_link_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.broker_link
    ADD CONSTRAINT constr_broker_link_pk PRIMARY KEY (identity_provider, user_id);


--
-- Name: client_user_session_note constr_cl_usr_ses_note; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_user_session_note
    ADD CONSTRAINT constr_cl_usr_ses_note PRIMARY KEY (client_session, name);


--
-- Name: component_config constr_component_config_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.component_config
    ADD CONSTRAINT constr_component_config_pk PRIMARY KEY (id);


--
-- Name: component constr_component_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.component
    ADD CONSTRAINT constr_component_pk PRIMARY KEY (id);


--
-- Name: fed_user_required_action constr_fed_required_action; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fed_user_required_action
    ADD CONSTRAINT constr_fed_required_action PRIMARY KEY (required_action, user_id);


--
-- Name: fed_user_attribute constr_fed_user_attr_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fed_user_attribute
    ADD CONSTRAINT constr_fed_user_attr_pk PRIMARY KEY (id);


--
-- Name: fed_user_consent constr_fed_user_consent_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fed_user_consent
    ADD CONSTRAINT constr_fed_user_consent_pk PRIMARY KEY (id);


--
-- Name: fed_user_credential constr_fed_user_cred_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fed_user_credential
    ADD CONSTRAINT constr_fed_user_cred_pk PRIMARY KEY (id);


--
-- Name: fed_user_group_membership constr_fed_user_group; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fed_user_group_membership
    ADD CONSTRAINT constr_fed_user_group PRIMARY KEY (group_id, user_id);


--
-- Name: fed_user_role_mapping constr_fed_user_role; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fed_user_role_mapping
    ADD CONSTRAINT constr_fed_user_role PRIMARY KEY (role_id, user_id);


--
-- Name: federated_user constr_federated_user; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.federated_user
    ADD CONSTRAINT constr_federated_user PRIMARY KEY (id);


--
-- Name: realm_default_groups constr_realm_default_groups; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT constr_realm_default_groups PRIMARY KEY (realm_id, group_id);


--
-- Name: realm_enabled_event_types constr_realm_enabl_event_types; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_enabled_event_types
    ADD CONSTRAINT constr_realm_enabl_event_types PRIMARY KEY (realm_id, value);


--
-- Name: realm_events_listeners constr_realm_events_listeners; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_events_listeners
    ADD CONSTRAINT constr_realm_events_listeners PRIMARY KEY (realm_id, value);


--
-- Name: realm_supported_locales constr_realm_supported_locales; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_supported_locales
    ADD CONSTRAINT constr_realm_supported_locales PRIMARY KEY (realm_id, value);


--
-- Name: identity_provider constraint_2b; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT constraint_2b PRIMARY KEY (internal_id);


--
-- Name: client_attributes constraint_3c; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_attributes
    ADD CONSTRAINT constraint_3c PRIMARY KEY (client_id, name);


--
-- Name: event_entity constraint_4; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.event_entity
    ADD CONSTRAINT constraint_4 PRIMARY KEY (id);


--
-- Name: federated_identity constraint_40; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.federated_identity
    ADD CONSTRAINT constraint_40 PRIMARY KEY (identity_provider, user_id);


--
-- Name: realm constraint_4a; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm
    ADD CONSTRAINT constraint_4a PRIMARY KEY (id);


--
-- Name: client_session_role constraint_5; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_session_role
    ADD CONSTRAINT constraint_5 PRIMARY KEY (client_session, role_id);


--
-- Name: user_session constraint_57; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_session
    ADD CONSTRAINT constraint_57 PRIMARY KEY (id);


--
-- Name: user_federation_provider constraint_5c; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_federation_provider
    ADD CONSTRAINT constraint_5c PRIMARY KEY (id);


--
-- Name: client_session_note constraint_5e; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_session_note
    ADD CONSTRAINT constraint_5e PRIMARY KEY (client_session, name);


--
-- Name: client constraint_7; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client
    ADD CONSTRAINT constraint_7 PRIMARY KEY (id);


--
-- Name: client_session constraint_8; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_session
    ADD CONSTRAINT constraint_8 PRIMARY KEY (id);


--
-- Name: scope_mapping constraint_81; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.scope_mapping
    ADD CONSTRAINT constraint_81 PRIMARY KEY (client_id, role_id);


--
-- Name: client_node_registrations constraint_84; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_node_registrations
    ADD CONSTRAINT constraint_84 PRIMARY KEY (client_id, name);


--
-- Name: realm_attribute constraint_9; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_attribute
    ADD CONSTRAINT constraint_9 PRIMARY KEY (name, realm_id);


--
-- Name: realm_required_credential constraint_92; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_required_credential
    ADD CONSTRAINT constraint_92 PRIMARY KEY (realm_id, type);


--
-- Name: keycloak_role constraint_a; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT constraint_a PRIMARY KEY (id);


--
-- Name: admin_event_entity constraint_admin_event_entity; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.admin_event_entity
    ADD CONSTRAINT constraint_admin_event_entity PRIMARY KEY (id);


--
-- Name: authenticator_config_entry constraint_auth_cfg_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authenticator_config_entry
    ADD CONSTRAINT constraint_auth_cfg_pk PRIMARY KEY (authenticator_id, name);


--
-- Name: authentication_execution constraint_auth_exec_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT constraint_auth_exec_pk PRIMARY KEY (id);


--
-- Name: authentication_flow constraint_auth_flow_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authentication_flow
    ADD CONSTRAINT constraint_auth_flow_pk PRIMARY KEY (id);


--
-- Name: authenticator_config constraint_auth_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authenticator_config
    ADD CONSTRAINT constraint_auth_pk PRIMARY KEY (id);


--
-- Name: client_session_auth_status constraint_auth_status_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_session_auth_status
    ADD CONSTRAINT constraint_auth_status_pk PRIMARY KEY (client_session, authenticator);


--
-- Name: user_role_mapping constraint_c; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_role_mapping
    ADD CONSTRAINT constraint_c PRIMARY KEY (role_id, user_id);


--
-- Name: composite_role constraint_composite_role; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT constraint_composite_role PRIMARY KEY (composite, child_role);


--
-- Name: client_session_prot_mapper constraint_cs_pmp_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_session_prot_mapper
    ADD CONSTRAINT constraint_cs_pmp_pk PRIMARY KEY (client_session, protocol_mapper_id);


--
-- Name: identity_provider_config constraint_d; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.identity_provider_config
    ADD CONSTRAINT constraint_d PRIMARY KEY (identity_provider_id, name);


--
-- Name: policy_config constraint_dpc; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.policy_config
    ADD CONSTRAINT constraint_dpc PRIMARY KEY (policy_id, name);


--
-- Name: realm_smtp_config constraint_e; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_smtp_config
    ADD CONSTRAINT constraint_e PRIMARY KEY (realm_id, name);


--
-- Name: credential constraint_f; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.credential
    ADD CONSTRAINT constraint_f PRIMARY KEY (id);


--
-- Name: user_federation_config constraint_f9; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_federation_config
    ADD CONSTRAINT constraint_f9 PRIMARY KEY (user_federation_provider_id, name);


--
-- Name: resource_server_perm_ticket constraint_fapmt; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT constraint_fapmt PRIMARY KEY (id);


--
-- Name: resource_server_resource constraint_farsr; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT constraint_farsr PRIMARY KEY (id);


--
-- Name: resource_server_policy constraint_farsrp; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT constraint_farsrp PRIMARY KEY (id);


--
-- Name: associated_policy constraint_farsrpap; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT constraint_farsrpap PRIMARY KEY (policy_id, associated_policy_id);


--
-- Name: resource_policy constraint_farsrpp; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT constraint_farsrpp PRIMARY KEY (resource_id, policy_id);


--
-- Name: resource_server_scope constraint_farsrs; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT constraint_farsrs PRIMARY KEY (id);


--
-- Name: resource_scope constraint_farsrsp; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT constraint_farsrsp PRIMARY KEY (resource_id, scope_id);


--
-- Name: scope_policy constraint_farsrsps; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT constraint_farsrsps PRIMARY KEY (scope_id, policy_id);


--
-- Name: user_entity constraint_fb; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT constraint_fb PRIMARY KEY (id);


--
-- Name: user_federation_mapper_config constraint_fedmapper_cfg_pm; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_federation_mapper_config
    ADD CONSTRAINT constraint_fedmapper_cfg_pm PRIMARY KEY (user_federation_mapper_id, name);


--
-- Name: user_federation_mapper constraint_fedmapperpm; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT constraint_fedmapperpm PRIMARY KEY (id);


--
-- Name: fed_user_consent_cl_scope constraint_fgrntcsnt_clsc_pm; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fed_user_consent_cl_scope
    ADD CONSTRAINT constraint_fgrntcsnt_clsc_pm PRIMARY KEY (user_consent_id, scope_id);


--
-- Name: user_consent_client_scope constraint_grntcsnt_clsc_pm; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_consent_client_scope
    ADD CONSTRAINT constraint_grntcsnt_clsc_pm PRIMARY KEY (user_consent_id, scope_id);


--
-- Name: user_consent constraint_grntcsnt_pm; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT constraint_grntcsnt_pm PRIMARY KEY (id);


--
-- Name: keycloak_group constraint_group; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.keycloak_group
    ADD CONSTRAINT constraint_group PRIMARY KEY (id);


--
-- Name: group_attribute constraint_group_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.group_attribute
    ADD CONSTRAINT constraint_group_attribute_pk PRIMARY KEY (id);


--
-- Name: group_role_mapping constraint_group_role; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.group_role_mapping
    ADD CONSTRAINT constraint_group_role PRIMARY KEY (role_id, group_id);


--
-- Name: identity_provider_mapper constraint_idpm; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.identity_provider_mapper
    ADD CONSTRAINT constraint_idpm PRIMARY KEY (id);


--
-- Name: idp_mapper_config constraint_idpmconfig; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.idp_mapper_config
    ADD CONSTRAINT constraint_idpmconfig PRIMARY KEY (idp_mapper_id, name);


--
-- Name: migration_model constraint_migmod; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.migration_model
    ADD CONSTRAINT constraint_migmod PRIMARY KEY (id);


--
-- Name: offline_client_session constraint_offl_cl_ses_pk3; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.offline_client_session
    ADD CONSTRAINT constraint_offl_cl_ses_pk3 PRIMARY KEY (user_session_id, client_id, client_storage_provider, external_client_id, offline_flag);


--
-- Name: offline_user_session constraint_offl_us_ses_pk2; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.offline_user_session
    ADD CONSTRAINT constraint_offl_us_ses_pk2 PRIMARY KEY (user_session_id, offline_flag);


--
-- Name: protocol_mapper constraint_pcm; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT constraint_pcm PRIMARY KEY (id);


--
-- Name: protocol_mapper_config constraint_pmconfig; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.protocol_mapper_config
    ADD CONSTRAINT constraint_pmconfig PRIMARY KEY (protocol_mapper_id, name);


--
-- Name: redirect_uris constraint_redirect_uris; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.redirect_uris
    ADD CONSTRAINT constraint_redirect_uris PRIMARY KEY (client_id, value);


--
-- Name: required_action_config constraint_req_act_cfg_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.required_action_config
    ADD CONSTRAINT constraint_req_act_cfg_pk PRIMARY KEY (required_action_id, name);


--
-- Name: required_action_provider constraint_req_act_prv_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.required_action_provider
    ADD CONSTRAINT constraint_req_act_prv_pk PRIMARY KEY (id);


--
-- Name: user_required_action constraint_required_action; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_required_action
    ADD CONSTRAINT constraint_required_action PRIMARY KEY (required_action, user_id);


--
-- Name: resource_uris constraint_resour_uris_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_uris
    ADD CONSTRAINT constraint_resour_uris_pk PRIMARY KEY (resource_id, value);


--
-- Name: role_attribute constraint_role_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.role_attribute
    ADD CONSTRAINT constraint_role_attribute_pk PRIMARY KEY (id);


--
-- Name: user_attribute constraint_user_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_attribute
    ADD CONSTRAINT constraint_user_attribute_pk PRIMARY KEY (id);


--
-- Name: user_group_membership constraint_user_group; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_group_membership
    ADD CONSTRAINT constraint_user_group PRIMARY KEY (group_id, user_id);


--
-- Name: user_session_note constraint_usn_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_session_note
    ADD CONSTRAINT constraint_usn_pk PRIMARY KEY (user_session, name);


--
-- Name: web_origins constraint_web_origins; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.web_origins
    ADD CONSTRAINT constraint_web_origins PRIMARY KEY (client_id, value);


--
-- Name: databasechangeloglock databasechangeloglock_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.databasechangeloglock
    ADD CONSTRAINT databasechangeloglock_pkey PRIMARY KEY (id);


--
-- Name: client_scope_attributes pk_cl_tmpl_attr; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_scope_attributes
    ADD CONSTRAINT pk_cl_tmpl_attr PRIMARY KEY (scope_id, name);


--
-- Name: client_scope pk_cli_template; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_scope
    ADD CONSTRAINT pk_cli_template PRIMARY KEY (id);


--
-- Name: resource_server pk_resource_server; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server
    ADD CONSTRAINT pk_resource_server PRIMARY KEY (id);


--
-- Name: client_scope_role_mapping pk_template_scope; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_scope_role_mapping
    ADD CONSTRAINT pk_template_scope PRIMARY KEY (scope_id, role_id);


--
-- Name: default_client_scope r_def_cli_scope_bind; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.default_client_scope
    ADD CONSTRAINT r_def_cli_scope_bind PRIMARY KEY (realm_id, scope_id);


--
-- Name: realm_localizations realm_localizations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_localizations
    ADD CONSTRAINT realm_localizations_pkey PRIMARY KEY (realm_id, locale);


--
-- Name: resource_attribute res_attr_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_attribute
    ADD CONSTRAINT res_attr_pk PRIMARY KEY (id);


--
-- Name: keycloak_group sibling_names; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.keycloak_group
    ADD CONSTRAINT sibling_names UNIQUE (realm_id, parent_group, name);


--
-- Name: identity_provider uk_2daelwnibji49avxsrtuf6xj33; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT uk_2daelwnibji49avxsrtuf6xj33 UNIQUE (provider_alias, realm_id);


--
-- Name: client uk_b71cjlbenv945rb6gcon438at; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client
    ADD CONSTRAINT uk_b71cjlbenv945rb6gcon438at UNIQUE (realm_id, client_id);


--
-- Name: client_scope uk_cli_scope; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_scope
    ADD CONSTRAINT uk_cli_scope UNIQUE (realm_id, name);


--
-- Name: user_entity uk_dykn684sl8up1crfei6eckhd7; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT uk_dykn684sl8up1crfei6eckhd7 UNIQUE (realm_id, email_constraint);


--
-- Name: resource_server_resource uk_frsr6t700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT uk_frsr6t700s9v50bu18ws5ha6 UNIQUE (name, owner, resource_server_id);


--
-- Name: resource_server_perm_ticket uk_frsr6t700s9v50bu18ws5pmt; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT uk_frsr6t700s9v50bu18ws5pmt UNIQUE (owner, requester, resource_server_id, resource_id, scope_id);


--
-- Name: resource_server_policy uk_frsrpt700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT uk_frsrpt700s9v50bu18ws5ha6 UNIQUE (name, resource_server_id);


--
-- Name: resource_server_scope uk_frsrst700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT uk_frsrst700s9v50bu18ws5ha6 UNIQUE (name, resource_server_id);


--
-- Name: user_consent uk_jkuwuvd56ontgsuhogm8uewrt; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT uk_jkuwuvd56ontgsuhogm8uewrt UNIQUE (client_id, client_storage_provider, external_client_id, user_id);


--
-- Name: realm uk_orvsdmla56612eaefiq6wl5oi; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm
    ADD CONSTRAINT uk_orvsdmla56612eaefiq6wl5oi UNIQUE (name);


--
-- Name: user_entity uk_ru8tt6t700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT uk_ru8tt6t700s9v50bu18ws5ha6 UNIQUE (realm_id, username);


--
-- Name: idx_admin_event_time; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_admin_event_time ON public.admin_event_entity USING btree (realm_id, admin_event_time);


--
-- Name: idx_assoc_pol_assoc_pol_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_assoc_pol_assoc_pol_id ON public.associated_policy USING btree (associated_policy_id);


--
-- Name: idx_auth_config_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_auth_config_realm ON public.authenticator_config USING btree (realm_id);


--
-- Name: idx_auth_exec_flow; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_auth_exec_flow ON public.authentication_execution USING btree (flow_id);


--
-- Name: idx_auth_exec_realm_flow; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_auth_exec_realm_flow ON public.authentication_execution USING btree (realm_id, flow_id);


--
-- Name: idx_auth_flow_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_auth_flow_realm ON public.authentication_flow USING btree (realm_id);


--
-- Name: idx_cl_clscope; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_cl_clscope ON public.client_scope_client USING btree (scope_id);


--
-- Name: idx_client_att_by_name_value; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_client_att_by_name_value ON public.client_attributes USING btree (name);


--
-- Name: idx_client_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_client_id ON public.client USING btree (client_id);


--
-- Name: idx_client_init_acc_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_client_init_acc_realm ON public.client_initial_access USING btree (realm_id);


--
-- Name: idx_client_session_session; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_client_session_session ON public.client_session USING btree (session_id);


--
-- Name: idx_clscope_attrs; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_clscope_attrs ON public.client_scope_attributes USING btree (scope_id);


--
-- Name: idx_clscope_cl; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_clscope_cl ON public.client_scope_client USING btree (client_id);


--
-- Name: idx_clscope_protmap; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_clscope_protmap ON public.protocol_mapper USING btree (client_scope_id);


--
-- Name: idx_clscope_role; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_clscope_role ON public.client_scope_role_mapping USING btree (scope_id);


--
-- Name: idx_compo_config_compo; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_compo_config_compo ON public.component_config USING btree (component_id);


--
-- Name: idx_component_provider_type; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_component_provider_type ON public.component USING btree (provider_type);


--
-- Name: idx_component_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_component_realm ON public.component USING btree (realm_id);


--
-- Name: idx_composite; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_composite ON public.composite_role USING btree (composite);


--
-- Name: idx_composite_child; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_composite_child ON public.composite_role USING btree (child_role);


--
-- Name: idx_defcls_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_defcls_realm ON public.default_client_scope USING btree (realm_id);


--
-- Name: idx_defcls_scope; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_defcls_scope ON public.default_client_scope USING btree (scope_id);


--
-- Name: idx_event_time; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_event_time ON public.event_entity USING btree (realm_id, event_time);


--
-- Name: idx_fedidentity_feduser; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fedidentity_feduser ON public.federated_identity USING btree (federated_user_id);


--
-- Name: idx_fedidentity_user; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fedidentity_user ON public.federated_identity USING btree (user_id);


--
-- Name: idx_fu_attribute; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_attribute ON public.fed_user_attribute USING btree (user_id, realm_id, name);


--
-- Name: idx_fu_cnsnt_ext; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_cnsnt_ext ON public.fed_user_consent USING btree (user_id, client_storage_provider, external_client_id);


--
-- Name: idx_fu_consent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_consent ON public.fed_user_consent USING btree (user_id, client_id);


--
-- Name: idx_fu_consent_ru; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_consent_ru ON public.fed_user_consent USING btree (realm_id, user_id);


--
-- Name: idx_fu_credential; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_credential ON public.fed_user_credential USING btree (user_id, type);


--
-- Name: idx_fu_credential_ru; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_credential_ru ON public.fed_user_credential USING btree (realm_id, user_id);


--
-- Name: idx_fu_group_membership; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_group_membership ON public.fed_user_group_membership USING btree (user_id, group_id);


--
-- Name: idx_fu_group_membership_ru; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_group_membership_ru ON public.fed_user_group_membership USING btree (realm_id, user_id);


--
-- Name: idx_fu_required_action; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_required_action ON public.fed_user_required_action USING btree (user_id, required_action);


--
-- Name: idx_fu_required_action_ru; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_required_action_ru ON public.fed_user_required_action USING btree (realm_id, user_id);


--
-- Name: idx_fu_role_mapping; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_role_mapping ON public.fed_user_role_mapping USING btree (user_id, role_id);


--
-- Name: idx_fu_role_mapping_ru; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_role_mapping_ru ON public.fed_user_role_mapping USING btree (realm_id, user_id);


--
-- Name: idx_group_attr_group; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_group_attr_group ON public.group_attribute USING btree (group_id);


--
-- Name: idx_group_role_mapp_group; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_group_role_mapp_group ON public.group_role_mapping USING btree (group_id);


--
-- Name: idx_id_prov_mapp_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_id_prov_mapp_realm ON public.identity_provider_mapper USING btree (realm_id);


--
-- Name: idx_ident_prov_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_ident_prov_realm ON public.identity_provider USING btree (realm_id);


--
-- Name: idx_keycloak_role_client; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_keycloak_role_client ON public.keycloak_role USING btree (client);


--
-- Name: idx_keycloak_role_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_keycloak_role_realm ON public.keycloak_role USING btree (realm);


--
-- Name: idx_offline_css_preload; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_offline_css_preload ON public.offline_client_session USING btree (client_id, offline_flag);


--
-- Name: idx_offline_uss_by_user; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_offline_uss_by_user ON public.offline_user_session USING btree (user_id, realm_id, offline_flag);


--
-- Name: idx_offline_uss_by_usersess; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_offline_uss_by_usersess ON public.offline_user_session USING btree (realm_id, offline_flag, user_session_id);


--
-- Name: idx_offline_uss_createdon; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_offline_uss_createdon ON public.offline_user_session USING btree (created_on);


--
-- Name: idx_offline_uss_preload; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_offline_uss_preload ON public.offline_user_session USING btree (offline_flag, created_on, user_session_id);


--
-- Name: idx_protocol_mapper_client; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_protocol_mapper_client ON public.protocol_mapper USING btree (client_id);


--
-- Name: idx_realm_attr_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_realm_attr_realm ON public.realm_attribute USING btree (realm_id);


--
-- Name: idx_realm_clscope; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_realm_clscope ON public.client_scope USING btree (realm_id);


--
-- Name: idx_realm_def_grp_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_realm_def_grp_realm ON public.realm_default_groups USING btree (realm_id);


--
-- Name: idx_realm_evt_list_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_realm_evt_list_realm ON public.realm_events_listeners USING btree (realm_id);


--
-- Name: idx_realm_evt_types_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_realm_evt_types_realm ON public.realm_enabled_event_types USING btree (realm_id);


--
-- Name: idx_realm_master_adm_cli; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_realm_master_adm_cli ON public.realm USING btree (master_admin_client);


--
-- Name: idx_realm_supp_local_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_realm_supp_local_realm ON public.realm_supported_locales USING btree (realm_id);


--
-- Name: idx_redir_uri_client; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_redir_uri_client ON public.redirect_uris USING btree (client_id);


--
-- Name: idx_req_act_prov_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_req_act_prov_realm ON public.required_action_provider USING btree (realm_id);


--
-- Name: idx_res_policy_policy; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_res_policy_policy ON public.resource_policy USING btree (policy_id);


--
-- Name: idx_res_scope_scope; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_res_scope_scope ON public.resource_scope USING btree (scope_id);


--
-- Name: idx_res_serv_pol_res_serv; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_res_serv_pol_res_serv ON public.resource_server_policy USING btree (resource_server_id);


--
-- Name: idx_res_srv_res_res_srv; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_res_srv_res_res_srv ON public.resource_server_resource USING btree (resource_server_id);


--
-- Name: idx_res_srv_scope_res_srv; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_res_srv_scope_res_srv ON public.resource_server_scope USING btree (resource_server_id);


--
-- Name: idx_role_attribute; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_role_attribute ON public.role_attribute USING btree (role_id);


--
-- Name: idx_role_clscope; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_role_clscope ON public.client_scope_role_mapping USING btree (role_id);


--
-- Name: idx_scope_mapping_role; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_scope_mapping_role ON public.scope_mapping USING btree (role_id);


--
-- Name: idx_scope_policy_policy; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_scope_policy_policy ON public.scope_policy USING btree (policy_id);


--
-- Name: idx_update_time; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_update_time ON public.migration_model USING btree (update_time);


--
-- Name: idx_us_sess_id_on_cl_sess; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_us_sess_id_on_cl_sess ON public.offline_client_session USING btree (user_session_id);


--
-- Name: idx_usconsent_clscope; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_usconsent_clscope ON public.user_consent_client_scope USING btree (user_consent_id);


--
-- Name: idx_user_attribute; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_user_attribute ON public.user_attribute USING btree (user_id);


--
-- Name: idx_user_attribute_name; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_user_attribute_name ON public.user_attribute USING btree (name, value);


--
-- Name: idx_user_consent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_user_consent ON public.user_consent USING btree (user_id);


--
-- Name: idx_user_credential; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_user_credential ON public.credential USING btree (user_id);


--
-- Name: idx_user_email; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_user_email ON public.user_entity USING btree (email);


--
-- Name: idx_user_group_mapping; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_user_group_mapping ON public.user_group_membership USING btree (user_id);


--
-- Name: idx_user_reqactions; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_user_reqactions ON public.user_required_action USING btree (user_id);


--
-- Name: idx_user_role_mapping; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_user_role_mapping ON public.user_role_mapping USING btree (user_id);


--
-- Name: idx_user_service_account; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_user_service_account ON public.user_entity USING btree (realm_id, service_account_client_link);


--
-- Name: idx_usr_fed_map_fed_prv; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_usr_fed_map_fed_prv ON public.user_federation_mapper USING btree (federation_provider_id);


--
-- Name: idx_usr_fed_map_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_usr_fed_map_realm ON public.user_federation_mapper USING btree (realm_id);


--
-- Name: idx_usr_fed_prv_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_usr_fed_prv_realm ON public.user_federation_provider USING btree (realm_id);


--
-- Name: idx_web_orig_client; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_web_orig_client ON public.web_origins USING btree (client_id);


--
-- Name: client_session_auth_status auth_status_constraint; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_session_auth_status
    ADD CONSTRAINT auth_status_constraint FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: identity_provider fk2b4ebc52ae5c3b34; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT fk2b4ebc52ae5c3b34 FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: client_attributes fk3c47c64beacca966; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_attributes
    ADD CONSTRAINT fk3c47c64beacca966 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: federated_identity fk404288b92ef007a6; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.federated_identity
    ADD CONSTRAINT fk404288b92ef007a6 FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: client_node_registrations fk4129723ba992f594; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_node_registrations
    ADD CONSTRAINT fk4129723ba992f594 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: client_session_note fk5edfb00ff51c2736; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_session_note
    ADD CONSTRAINT fk5edfb00ff51c2736 FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: user_session_note fk5edfb00ff51d3472; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_session_note
    ADD CONSTRAINT fk5edfb00ff51d3472 FOREIGN KEY (user_session) REFERENCES public.user_session(id);


--
-- Name: client_session_role fk_11b7sgqw18i532811v7o2dv76; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_session_role
    ADD CONSTRAINT fk_11b7sgqw18i532811v7o2dv76 FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: redirect_uris fk_1burs8pb4ouj97h5wuppahv9f; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.redirect_uris
    ADD CONSTRAINT fk_1burs8pb4ouj97h5wuppahv9f FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: user_federation_provider fk_1fj32f6ptolw2qy60cd8n01e8; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_federation_provider
    ADD CONSTRAINT fk_1fj32f6ptolw2qy60cd8n01e8 FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: client_session_prot_mapper fk_33a8sgqw18i532811v7o2dk89; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_session_prot_mapper
    ADD CONSTRAINT fk_33a8sgqw18i532811v7o2dk89 FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: realm_required_credential fk_5hg65lybevavkqfki3kponh9v; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_required_credential
    ADD CONSTRAINT fk_5hg65lybevavkqfki3kponh9v FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: resource_attribute fk_5hrm2vlf9ql5fu022kqepovbr; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_attribute
    ADD CONSTRAINT fk_5hrm2vlf9ql5fu022kqepovbr FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: user_attribute fk_5hrm2vlf9ql5fu043kqepovbr; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_attribute
    ADD CONSTRAINT fk_5hrm2vlf9ql5fu043kqepovbr FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: user_required_action fk_6qj3w1jw9cvafhe19bwsiuvmd; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_required_action
    ADD CONSTRAINT fk_6qj3w1jw9cvafhe19bwsiuvmd FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: keycloak_role fk_6vyqfe4cn4wlq8r6kt5vdsj5c; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT fk_6vyqfe4cn4wlq8r6kt5vdsj5c FOREIGN KEY (realm) REFERENCES public.realm(id);


--
-- Name: realm_smtp_config fk_70ej8xdxgxd0b9hh6180irr0o; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_smtp_config
    ADD CONSTRAINT fk_70ej8xdxgxd0b9hh6180irr0o FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: realm_attribute fk_8shxd6l3e9atqukacxgpffptw; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_attribute
    ADD CONSTRAINT fk_8shxd6l3e9atqukacxgpffptw FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: composite_role fk_a63wvekftu8jo1pnj81e7mce2; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT fk_a63wvekftu8jo1pnj81e7mce2 FOREIGN KEY (composite) REFERENCES public.keycloak_role(id);


--
-- Name: authentication_execution fk_auth_exec_flow; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT fk_auth_exec_flow FOREIGN KEY (flow_id) REFERENCES public.authentication_flow(id);


--
-- Name: authentication_execution fk_auth_exec_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT fk_auth_exec_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: authentication_flow fk_auth_flow_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authentication_flow
    ADD CONSTRAINT fk_auth_flow_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: authenticator_config fk_auth_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authenticator_config
    ADD CONSTRAINT fk_auth_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: client_session fk_b4ao2vcvat6ukau74wbwtfqo1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_session
    ADD CONSTRAINT fk_b4ao2vcvat6ukau74wbwtfqo1 FOREIGN KEY (session_id) REFERENCES public.user_session(id);


--
-- Name: user_role_mapping fk_c4fqv34p1mbylloxang7b1q3l; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_role_mapping
    ADD CONSTRAINT fk_c4fqv34p1mbylloxang7b1q3l FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: client_scope_attributes fk_cl_scope_attr_scope; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_scope_attributes
    ADD CONSTRAINT fk_cl_scope_attr_scope FOREIGN KEY (scope_id) REFERENCES public.client_scope(id);


--
-- Name: client_scope_role_mapping fk_cl_scope_rm_scope; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_scope_role_mapping
    ADD CONSTRAINT fk_cl_scope_rm_scope FOREIGN KEY (scope_id) REFERENCES public.client_scope(id);


--
-- Name: client_user_session_note fk_cl_usr_ses_note; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_user_session_note
    ADD CONSTRAINT fk_cl_usr_ses_note FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: protocol_mapper fk_cli_scope_mapper; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT fk_cli_scope_mapper FOREIGN KEY (client_scope_id) REFERENCES public.client_scope(id);


--
-- Name: client_initial_access fk_client_init_acc_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_initial_access
    ADD CONSTRAINT fk_client_init_acc_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: component_config fk_component_config; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.component_config
    ADD CONSTRAINT fk_component_config FOREIGN KEY (component_id) REFERENCES public.component(id);


--
-- Name: component fk_component_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.component
    ADD CONSTRAINT fk_component_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: realm_default_groups fk_def_groups_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT fk_def_groups_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: user_federation_mapper_config fk_fedmapper_cfg; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_federation_mapper_config
    ADD CONSTRAINT fk_fedmapper_cfg FOREIGN KEY (user_federation_mapper_id) REFERENCES public.user_federation_mapper(id);


--
-- Name: user_federation_mapper fk_fedmapperpm_fedprv; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT fk_fedmapperpm_fedprv FOREIGN KEY (federation_provider_id) REFERENCES public.user_federation_provider(id);


--
-- Name: user_federation_mapper fk_fedmapperpm_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT fk_fedmapperpm_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: associated_policy fk_frsr5s213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT fk_frsr5s213xcx4wnkog82ssrfy FOREIGN KEY (associated_policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: scope_policy fk_frsrasp13xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT fk_frsrasp13xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog82sspmt; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog82sspmt FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: resource_server_resource fk_frsrho213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT fk_frsrho213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog83sspmt; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog83sspmt FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog84sspmt; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog84sspmt FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- Name: associated_policy fk_frsrpas14xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT fk_frsrpas14xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: scope_policy fk_frsrpass3xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT fk_frsrpass3xcx4wnkog82ssrfy FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- Name: resource_server_perm_ticket fk_frsrpo2128cx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrpo2128cx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: resource_server_policy fk_frsrpo213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT fk_frsrpo213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: resource_scope fk_frsrpos13xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT fk_frsrpos13xcx4wnkog82ssrfy FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: resource_policy fk_frsrpos53xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT fk_frsrpos53xcx4wnkog82ssrfy FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: resource_policy fk_frsrpp213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT fk_frsrpp213xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: resource_scope fk_frsrps213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT fk_frsrps213xcx4wnkog82ssrfy FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- Name: resource_server_scope fk_frsrso213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT fk_frsrso213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: composite_role fk_gr7thllb9lu8q4vqa4524jjy8; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT fk_gr7thllb9lu8q4vqa4524jjy8 FOREIGN KEY (child_role) REFERENCES public.keycloak_role(id);


--
-- Name: user_consent_client_scope fk_grntcsnt_clsc_usc; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_consent_client_scope
    ADD CONSTRAINT fk_grntcsnt_clsc_usc FOREIGN KEY (user_consent_id) REFERENCES public.user_consent(id);


--
-- Name: user_consent fk_grntcsnt_user; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT fk_grntcsnt_user FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: group_attribute fk_group_attribute_group; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.group_attribute
    ADD CONSTRAINT fk_group_attribute_group FOREIGN KEY (group_id) REFERENCES public.keycloak_group(id);


--
-- Name: group_role_mapping fk_group_role_group; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.group_role_mapping
    ADD CONSTRAINT fk_group_role_group FOREIGN KEY (group_id) REFERENCES public.keycloak_group(id);


--
-- Name: realm_enabled_event_types fk_h846o4h0w8epx5nwedrf5y69j; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_enabled_event_types
    ADD CONSTRAINT fk_h846o4h0w8epx5nwedrf5y69j FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: realm_events_listeners fk_h846o4h0w8epx5nxev9f5y69j; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_events_listeners
    ADD CONSTRAINT fk_h846o4h0w8epx5nxev9f5y69j FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: identity_provider_mapper fk_idpm_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.identity_provider_mapper
    ADD CONSTRAINT fk_idpm_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: idp_mapper_config fk_idpmconfig; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.idp_mapper_config
    ADD CONSTRAINT fk_idpmconfig FOREIGN KEY (idp_mapper_id) REFERENCES public.identity_provider_mapper(id);


--
-- Name: web_origins fk_lojpho213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.web_origins
    ADD CONSTRAINT fk_lojpho213xcx4wnkog82ssrfy FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: scope_mapping fk_ouse064plmlr732lxjcn1q5f1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.scope_mapping
    ADD CONSTRAINT fk_ouse064plmlr732lxjcn1q5f1 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: protocol_mapper fk_pcm_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT fk_pcm_realm FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: credential fk_pfyr0glasqyl0dei3kl69r6v0; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.credential
    ADD CONSTRAINT fk_pfyr0glasqyl0dei3kl69r6v0 FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: protocol_mapper_config fk_pmconfig; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.protocol_mapper_config
    ADD CONSTRAINT fk_pmconfig FOREIGN KEY (protocol_mapper_id) REFERENCES public.protocol_mapper(id);


--
-- Name: default_client_scope fk_r_def_cli_scope_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.default_client_scope
    ADD CONSTRAINT fk_r_def_cli_scope_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: required_action_provider fk_req_act_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.required_action_provider
    ADD CONSTRAINT fk_req_act_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: resource_uris fk_resource_server_uris; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_uris
    ADD CONSTRAINT fk_resource_server_uris FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: role_attribute fk_role_attribute_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.role_attribute
    ADD CONSTRAINT fk_role_attribute_id FOREIGN KEY (role_id) REFERENCES public.keycloak_role(id);


--
-- Name: realm_supported_locales fk_supported_locales_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_supported_locales
    ADD CONSTRAINT fk_supported_locales_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: user_federation_config fk_t13hpu1j94r2ebpekr39x5eu5; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_federation_config
    ADD CONSTRAINT fk_t13hpu1j94r2ebpekr39x5eu5 FOREIGN KEY (user_federation_provider_id) REFERENCES public.user_federation_provider(id);


--
-- Name: user_group_membership fk_user_group_user; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_group_membership
    ADD CONSTRAINT fk_user_group_user FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: policy_config fkdc34197cf864c4e43; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.policy_config
    ADD CONSTRAINT fkdc34197cf864c4e43 FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: identity_provider_config fkdc4897cf864c4e43; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.identity_provider_config
    ADD CONSTRAINT fkdc4897cf864c4e43 FOREIGN KEY (identity_provider_id) REFERENCES public.identity_provider(internal_id);


--
-- PostgreSQL database dump complete
--


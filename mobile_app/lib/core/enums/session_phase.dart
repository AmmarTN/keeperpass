/// Steps of the sign-in flow, in order (web `SessionPhase`): provider
/// sign-in, then the secret that opens (or creates) the vault.
enum SessionPhase { signedOut, awaitingSecret, ready }

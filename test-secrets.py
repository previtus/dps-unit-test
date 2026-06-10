from maap.maap import MAAP
maap = MAAP()

print(maap.secrets.get_secrets())
print(maap.secrets.get_secret("foobar"))

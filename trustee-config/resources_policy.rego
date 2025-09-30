package policy

default allow = false

print(input)

allow {
    input["submods"]["cpu"]["ear.veraison.annotated-evidence"]["sample"]["launch_digest"] == "abcde"
}
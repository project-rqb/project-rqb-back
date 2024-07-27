3.times do |i|
  user = User.create!(
    uid: i + 1,
    provider: "github",
    github_uid: "github_#{i + 1}",
    name: "testname_#{i + 1}",
    term_id: rand(1..10),
    profile: "This profile is test_#{i + 1}."
  )

  user.questions.create!(
    uuid: SecureRandom.uuid,
    title: "This title is test_#{i + 1}.",
    body: "This body is test_#{i + 1}.",
    status: 0
  )
end

sig User{
	courses: set Course,
	submissions: set Submission
}
sig Course{
	topics: set Topic
}
sig Topic{
	parents: set Topic,
	children: set Topic,
	problems: set Problem,
	tutorial: one Tutorial
}
sig Submission{
	problem: one Problem,
	verdict: one Verdict
}
sig Problem{}
sig Tutorial{}

abstract sig Verdict{}
one sig MLE, TLE, RE, WA, ILE, DJ extends Verdict{}

fact User{
	all u: User | #u.courses > 0 // all users have at least one course
	all s: Submission | #(s.~submissions) = 1 // a submission belongs to only one user
}

fact Course{
	all c: Course | #c.topics > 0 // all courses have at least one topic
}

fact Tutorial{
	all t: Tutorial | #(t.~tutorial) = 1 // a tutorial belongs to only one topic
}

fact Topic{
	all t: Topic | #(t.~topics) > 0 // topics belong to at least one course
	all t: Topic | !(t in t.^parents) // topics can't be parent of themselves and parent of their parents
	all t: Topic | !(t in t.^children) // topics can't be child of themselves and child of their children
	all t1: Topic, t2: Topic | t1 in t2.children <=> t2 in t1.parents // a topic is always parent of his children
}

pred show[]{}
run show for 10 but exactly 2 User, exactly 2 Course, exactly 5 Topic

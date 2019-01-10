import IntercomChallengeFramework

ApplicationFacade.solveIntercomChallenge() { result in
    switch result {
    case .success(let customers):
        customers.forEach { customer in
            print(customer)
        }
    case .error(let error):
        print(error)
    }
}

;; disability-community-platform
;; Peer support network and resource sharing for disability advocacy and mutual aid
;; This contract manages community connections, resource sharing, advocacy campaigns,
;; and mutual aid coordination within the disability community.

;; Error constants
(define-constant ERR-UNAUTHORIZED (err u400))
(define-constant ERR-NOT-FOUND (err u401))
(define-constant ERR-ALREADY-EXISTS (err u402))
(define-constant ERR-INVALID-PARAMETERS (err u403))
(define-constant ERR-INSUFFICIENT-RESOURCES (err u404))
(define-constant ERR-PERMISSION-DENIED (err u405))
(define-constant ERR-COMMUNITY-FULL (err u406))
(define-constant ERR-RESOURCE-UNAVAILABLE (err u407))
(define-constant ERR-INVALID-REQUEST-TYPE (err u408))

;; Community member role constants
(define-constant ROLE-MEMBER u1)
(define-constant ROLE-ADVOCATE u2)
(define-constant ROLE-MENTOR u3)
(define-constant ROLE-RESOURCE-PROVIDER u4)
(define-constant ROLE-ORGANIZER u5)
(define-constant ROLE-MODERATOR u6)

;; Resource type constants
(define-constant RESOURCE-INFORMATION u1)
(define-constant RESOURCE-EQUIPMENT u2)
(define-constant RESOURCE-SERVICE u3)
(define-constant RESOURCE-FUNDING u4)
(define-constant RESOURCE-EMOTIONAL-SUPPORT u5)
(define-constant RESOURCE-TRANSPORTATION u6)
(define-constant RESOURCE-ACCOMMODATION u7)
(define-constant RESOURCE-EDUCATIONAL u8)

;; Request status constants
(define-constant STATUS-OPEN u1)
(define-constant STATUS-IN-PROGRESS u2)
(define-constant STATUS-FULFILLED u3)
(define-constant STATUS-CLOSED u4)
(define-constant STATUS-CANCELLED u5)

;; Advocacy campaign status constants
(define-constant CAMPAIGN-PLANNING u1)
(define-constant CAMPAIGN-ACTIVE u2)
(define-constant CAMPAIGN-COMPLETED u3)
(define-constant CAMPAIGN-PAUSED u4)

;; Priority level constants
(define-constant PRIORITY-LOW u1)
(define-constant PRIORITY-MEDIUM u2)
(define-constant PRIORITY-HIGH u3)
(define-constant PRIORITY-URGENT u4)

;; Data variables
(define-data-var member-counter uint u0)
(define-data-var resource-counter uint u0)
(define-data-var request-counter uint u0)
(define-data-var campaign-counter uint u0)
(define-data-var contract-admin principal tx-sender)

;; Community member profiles
(define-map community-members
  principal
  {
    member-id: uint,
    display-name: (string-ascii 100),
    role: uint,
    disability-experience: (string-ascii 500),
    interests: (list 10 (string-ascii 50)),
    skills: (list 10 (string-ascii 50)),
    location: (string-ascii 100),
    joined-date: uint,
    last-active: uint,
    reputation-score: uint,
    privacy-settings: uint,
    contact-preferences: (string-ascii 200)
  }
)

;; Resource sharing database
(define-map community-resources
  uint
  {
    resource-name: (string-ascii 200),
    resource-type: uint,
    description: (string-ascii 800),
    provider: principal,
    availability-status: uint,
    location: (string-ascii 100),
    cost: uint,
    requirements: (string-ascii 400),
    contact-method: (string-ascii 200),
    tags: (list 10 (string-ascii 30)),
    created-date: uint,
    last-updated: uint,
    usage-count: uint
  }
)

;; Mutual aid requests
(define-map mutual-aid-requests
  uint
  {
    requester: principal,
    request-title: (string-ascii 200),
    request-type: uint,
    description: (string-ascii 800),
    urgency-level: uint,
    location: (string-ascii 100),
    deadline: (optional uint),
    status: uint,
    assigned-helper: (optional principal),
    created-date: uint,
    fulfilled-date: (optional uint),
    community-notes: (string-ascii 500),
    verification-required: bool
  }
)

;; Peer support connections
(define-map peer-connections
  { mentor: principal, mentee: principal }
  {
    connection-type: (string-ascii 50),
    shared-experiences: (list 5 (string-ascii 100)),
    connection-date: uint,
    interaction-frequency: uint,
    support-goals: (string-ascii 400),
    progress-notes: (string-ascii 600),
    connection-status: uint,
    mutual-rating: uint,
    next-check-in: (optional uint)
  }
)

;; Advocacy campaigns
(define-map advocacy-campaigns
  uint
  {
    campaign-name: (string-ascii 200),
    organizer: principal,
    campaign-type: (string-ascii 100),
    description: (string-ascii 1000),
    goals: (list 5 (string-ascii 200)),
    target-audience: (string-ascii 200),
    timeline: (string-ascii 300),
    status: uint,
    supporters: (list 100 principal),
    resources-needed: (list 10 (string-ascii 100)),
    progress-updates: (string-ascii 800),
    created-date: uint,
    expected-completion: (optional uint)
  }
)

;; Community events and gatherings
(define-map community-events
  uint
  {
    event-name: (string-ascii 200),
    organizer: principal,
    event-type: (string-ascii 100),
    description: (string-ascii 800),
    date-time: uint,
    location: (string-ascii 200),
    accessibility-features: (string-ascii 500),
    capacity: uint,
    registered-attendees: (list 50 principal),
    requirements: (string-ascii 300),
    cost: uint,
    contact-info: (string-ascii 200),
    status: uint
  }
)

;; Knowledge sharing and educational content
(define-map knowledge-base
  uint
  {
    title: (string-ascii 200),
    author: principal,
    content-type: (string-ascii 50),
    category: (string-ascii 100),
    content-summary: (string-ascii 500),
    accessibility-level: uint,
    language: (string-ascii 30),
    tags: (list 10 (string-ascii 30)),
    upvotes: uint,
    created-date: uint,
    last-updated: uint,
    view-count: uint,
    moderator-approved: bool
  }
)

;; Community feedback and suggestions
(define-map community-feedback
  uint
  {
    contributor: principal,
    feedback-type: (string-ascii 50),
    subject: (string-ascii 200),
    detailed-feedback: (string-ascii 800),
    suggestions: (string-ascii 500),
    priority-level: uint,
    category: (string-ascii 100),
    submission-date: uint,
    status: uint,
    moderator-response: (string-ascii 400),
    implementation-notes: (string-ascii 300)
  }
)

;; Accessibility accommodation requests
(define-map accommodation-requests
  uint
  {
    requester: principal,
    accommodation-type: (string-ascii 100),
    description: (string-ascii 600),
    context: (string-ascii 400),
    urgency: uint,
    estimated-cost: uint,
    justification: (string-ascii 500),
    status: uint,
    approved-by: (optional principal),
    implementation-date: (optional uint),
    request-date: uint,
    notes: (string-ascii 400)
  }
)

;; Private helper functions
(define-private (is-admin (caller principal))
  (is-eq caller (var-get contract-admin))
)

(define-private (is-community-member (member principal))
  (is-some (map-get? community-members member))
)

(define-private (is-valid-role (role uint))
  (and (>= role u1) (<= role u6))
)

(define-private (is-valid-resource-type (resource-type uint))
  (and (>= resource-type u1) (<= resource-type u8))
)

(define-private (is-valid-priority (priority uint))
  (and (>= priority u1) (<= priority u4))
)

(define-private (get-current-time)
  stacks-block-height
)

(define-private (calculate-reputation-score (contributions uint) (ratings uint))
  (if (> contributions u0)
    (/ (* ratings u100) contributions)
    u0
  )
)

;; Public functions for community management

;; Join the disability community
(define-public (join-community
    (display-name (string-ascii 100))
    (disability-experience (string-ascii 500))
    (interests (list 10 (string-ascii 50)))
    (skills (list 10 (string-ascii 50)))
    (location (string-ascii 100))
    (privacy-settings uint)
  )
  (let (
    (new-member-id (+ (var-get member-counter) u1))
    (current-time (get-current-time))
  )
    (begin
      (asserts! (not (is-community-member tx-sender)) ERR-ALREADY-EXISTS)
      (asserts! (> (len display-name) u0) ERR-INVALID-PARAMETERS)
      (asserts! (and (>= privacy-settings u1) (<= privacy-settings u3)) ERR-INVALID-PARAMETERS)
      
      (map-set community-members tx-sender {
        member-id: new-member-id,
        display-name: display-name,
        role: ROLE-MEMBER,
        disability-experience: disability-experience,
        interests: interests,
        skills: skills,
        location: location,
        joined-date: current-time,
        last-active: current-time,
        reputation-score: u50,
        privacy-settings: privacy-settings,
        contact-preferences: ""
      })
      
      (var-set member-counter new-member-id)
      (ok new-member-id)
    )
  )
)

;; Share a resource with the community
(define-public (share-resource
    (resource-name (string-ascii 200))
    (resource-type uint)
    (description (string-ascii 800))
    (location (string-ascii 100))
    (cost uint)
    (requirements (string-ascii 400))
    (contact-method (string-ascii 200))
    (tags (list 10 (string-ascii 30)))
  )
  (let (
    (new-resource-id (+ (var-get resource-counter) u1))
    (current-time (get-current-time))
  )
    (begin
      (asserts! (is-community-member tx-sender) ERR-UNAUTHORIZED)
      (asserts! (is-valid-resource-type resource-type) ERR-INVALID-PARAMETERS)
      (asserts! (> (len resource-name) u0) ERR-INVALID-PARAMETERS)
      
      (map-set community-resources new-resource-id {
        resource-name: resource-name,
        resource-type: resource-type,
        description: description,
        provider: tx-sender,
        availability-status: STATUS-OPEN,
        location: location,
        cost: cost,
        requirements: requirements,
        contact-method: contact-method,
        tags: tags,
        created-date: current-time,
        last-updated: current-time,
        usage-count: u0
      })
      
      (var-set resource-counter new-resource-id)
      (ok new-resource-id)
    )
  )
)

;; Submit a mutual aid request
(define-public (submit-mutual-aid-request
    (request-title (string-ascii 200))
    (request-type uint)
    (description (string-ascii 800))
    (urgency-level uint)
    (location (string-ascii 100))
    (deadline (optional uint))
    (verification-required bool)
  )
  (let (
    (new-request-id (+ (var-get request-counter) u1))
    (current-time (get-current-time))
  )
    (begin
      (asserts! (is-community-member tx-sender) ERR-UNAUTHORIZED)
      (asserts! (is-valid-resource-type request-type) ERR-INVALID-PARAMETERS)
      (asserts! (is-valid-priority urgency-level) ERR-INVALID-PARAMETERS)
      (asserts! (> (len request-title) u0) ERR-INVALID-PARAMETERS)
      
      (map-set mutual-aid-requests new-request-id {
        requester: tx-sender,
        request-title: request-title,
        request-type: request-type,
        description: description,
        urgency-level: urgency-level,
        location: location,
        deadline: deadline,
        status: STATUS-OPEN,
        assigned-helper: none,
        created-date: current-time,
        fulfilled-date: none,
        community-notes: "",
        verification-required: verification-required
      })
      
      (var-set request-counter new-request-id)
      (ok new-request-id)
    )
  )
)

;; Establish peer support connection
(define-public (create-peer-connection
    (mentee principal)
    (connection-type (string-ascii 50))
    (shared-experiences (list 5 (string-ascii 100)))
    (support-goals (string-ascii 400))
  )
  (let (
    (current-time (get-current-time))
  )
    (begin
      (asserts! (is-community-member tx-sender) ERR-UNAUTHORIZED)
      (asserts! (is-community-member mentee) ERR-NOT-FOUND)
      (asserts! (not (is-eq tx-sender mentee)) ERR-INVALID-PARAMETERS)
      (asserts! (is-none (map-get? peer-connections { mentor: tx-sender, mentee: mentee })) ERR-ALREADY-EXISTS)
      
      (map-set peer-connections { mentor: tx-sender, mentee: mentee } {
        connection-type: connection-type,
        shared-experiences: shared-experiences,
        connection-date: current-time,
        interaction-frequency: u1,
        support-goals: support-goals,
        progress-notes: "",
        connection-status: STATUS-OPEN,
        mutual-rating: u0,
        next-check-in: (some (+ current-time u144)) ;; weekly check-in
      })
      
      (ok true)
    )
  )
)

;; Launch advocacy campaign
(define-public (launch-advocacy-campaign
    (campaign-name (string-ascii 200))
    (campaign-type (string-ascii 100))
    (description (string-ascii 1000))
    (goals (list 5 (string-ascii 200)))
    (target-audience (string-ascii 200))
    (timeline (string-ascii 300))
    (resources-needed (list 10 (string-ascii 100)))
  )
  (let (
    (new-campaign-id (+ (var-get campaign-counter) u1))
    (current-time (get-current-time))
  )
    (begin
      (asserts! (is-community-member tx-sender) ERR-UNAUTHORIZED)
      (asserts! (> (len campaign-name) u0) ERR-INVALID-PARAMETERS)
      (asserts! (> (len goals) u0) ERR-INVALID-PARAMETERS)
      
      (map-set advocacy-campaigns new-campaign-id {
        campaign-name: campaign-name,
        organizer: tx-sender,
        campaign-type: campaign-type,
        description: description,
        goals: goals,
        target-audience: target-audience,
        timeline: timeline,
        status: CAMPAIGN-PLANNING,
        supporters: (list tx-sender),
        resources-needed: resources-needed,
        progress-updates: "",
        created-date: current-time,
        expected-completion: none
      })
      
      (var-set campaign-counter new-campaign-id)
      (ok new-campaign-id)
    )
  )
)

;; Support an advocacy campaign
(define-public (support-campaign (campaign-id uint))
  (let (
    (campaign-data (unwrap! (map-get? advocacy-campaigns campaign-id) ERR-NOT-FOUND))
    (current-supporters (get supporters campaign-data))
  )
    (begin
      (asserts! (is-community-member tx-sender) ERR-UNAUTHORIZED)
      (asserts! (not (is-some (index-of current-supporters tx-sender))) ERR-ALREADY-EXISTS)
      
      (map-set advocacy-campaigns campaign-id
        (merge campaign-data {
          supporters: (unwrap! (as-max-len? (append current-supporters tx-sender) u100) ERR-COMMUNITY-FULL)
        })
      )
      
      (ok true)
    )
  )
)

;; Respond to mutual aid request
(define-public (respond-to-aid-request
    (request-id uint)
    (response-message (string-ascii 400))
  )
  (let (
    (request-data (unwrap! (map-get? mutual-aid-requests request-id) ERR-NOT-FOUND))
  )
    (begin
      (asserts! (is-community-member tx-sender) ERR-UNAUTHORIZED)
      (asserts! (is-eq (get status request-data) STATUS-OPEN) ERR-INVALID-PARAMETERS)
      (asserts! (not (is-eq tx-sender (get requester request-data))) ERR-INVALID-PARAMETERS)
      
      (map-set mutual-aid-requests request-id
        (merge request-data {
          status: STATUS-IN-PROGRESS,
          assigned-helper: (some tx-sender),
          community-notes: response-message
        })
      )
      
      (ok true)
    )
  )
)

;; Submit community feedback
(define-public (submit-community-feedback
    (feedback-type (string-ascii 50))
    (subject (string-ascii 200))
    (detailed-feedback (string-ascii 800))
    (suggestions (string-ascii 500))
    (priority-level uint)
    (category (string-ascii 100))
  )
  (let (
    (feedback-id (+ (var-get member-counter) u5000))
    (current-time (get-current-time))
  )
    (begin
      (asserts! (is-community-member tx-sender) ERR-UNAUTHORIZED)
      (asserts! (is-valid-priority priority-level) ERR-INVALID-PARAMETERS)
      (asserts! (> (len subject) u0) ERR-INVALID-PARAMETERS)
      
      (map-set community-feedback feedback-id {
        contributor: tx-sender,
        feedback-type: feedback-type,
        subject: subject,
        detailed-feedback: detailed-feedback,
        suggestions: suggestions,
        priority-level: priority-level,
        category: category,
        submission-date: current-time,
        status: STATUS-OPEN,
        moderator-response: "",
        implementation-notes: ""
      })
      
      (ok feedback-id)
    )
  )
)

;; Request accessibility accommodation
(define-public (request-accommodation
    (accommodation-type (string-ascii 100))
    (description (string-ascii 600))
    (context (string-ascii 400))
    (urgency uint)
    (estimated-cost uint)
    (justification (string-ascii 500))
  )
  (let (
    (accommodation-id (+ (var-get member-counter) u7000))
    (current-time (get-current-time))
  )
    (begin
      (asserts! (is-community-member tx-sender) ERR-UNAUTHORIZED)
      (asserts! (is-valid-priority urgency) ERR-INVALID-PARAMETERS)
      (asserts! (> (len accommodation-type) u0) ERR-INVALID-PARAMETERS)
      
      (map-set accommodation-requests accommodation-id {
        requester: tx-sender,
        accommodation-type: accommodation-type,
        description: description,
        context: context,
        urgency: urgency,
        estimated-cost: estimated-cost,
        justification: justification,
        status: STATUS-OPEN,
        approved-by: none,
        implementation-date: none,
        request-date: current-time,
        notes: ""
      })
      
      (ok accommodation-id)
    )
  )
)

;; Read-only functions for data access
(define-read-only (get-member-profile (member principal))
  (map-get? community-members member)
)

(define-read-only (get-community-resource (resource-id uint))
  (map-get? community-resources resource-id)
)

(define-read-only (get-mutual-aid-request (request-id uint))
  (map-get? mutual-aid-requests request-id)
)

(define-read-only (get-peer-connection (mentor principal) (mentee principal))
  (map-get? peer-connections { mentor: mentor, mentee: mentee })
)

(define-read-only (get-advocacy-campaign (campaign-id uint))
  (map-get? advocacy-campaigns campaign-id)
)

(define-read-only (get-community-feedback (feedback-id uint))
  (map-get? community-feedback feedback-id)
)

(define-read-only (get-accommodation-request (accommodation-id uint))
  (map-get? accommodation-requests accommodation-id)
)

(define-read-only (get-member-count)
  (var-get member-counter)
)

(define-read-only (get-resource-count)
  (var-get resource-counter)
)

(define-read-only (get-campaign-count)
  (var-get campaign-counter)
)

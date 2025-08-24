;; ---------------------------------------------------
;; Decentralized Tip Jar
;; ---------------------------------------------------
;; Users can send STX tips, and the contract owner
;; can withdraw the collected balance.
;; ---------------------------------------------------

(define-constant ERR-NOT-AUTHORIZED (err u100))
(define-constant ERR-NO-FUNDS (err u101))

(define-data-var owner principal tx-sender) ;; contract deployer is the owner
(define-data-var total-tips uint u0)        ;; total STX tipped

;; Public function: Users send a tip by attaching STX
(define-public (send-tip (amount uint))
  (let ((transfer-result (stx-transfer? amount tx-sender (var-get owner))))
    (if (is-ok transfer-result)
        (begin
          (var-set total-tips (+ (var-get total-tips) amount))
          (ok { sender: tx-sender, amount: amount })
        )
        (err u102) ;; return a matching error type
    )
  )
)

;; Owner can withdraw all tips to a chosen address
(define-public (withdraw-tips (to principal))
  (begin
    (if (is-eq tx-sender (var-get owner))
        (let ((balance (var-get total-tips)))
          (if (> balance u0)
              (begin
                (var-set total-tips u0)
                (stx-transfer? balance (var-get owner) to)
              )
              ERR-NO-FUNDS
          )
        )
        ERR-NOT-AUTHORIZED
    )
  )
)

;; Read-only: Get total tips collected
(define-read-only (get-total-tips)
  (ok (var-get total-tips))
)

;; Read-only: Get owner
(define-read-only (get-owner)
  (ok (var-get owner))
)

;; csauer: use org-goto to jump to projects (https://emacs.stackexchange.com/questions/32617/how-to-jump-directly-to-an-org-headline)
(setq org-goto-interface 'outline-path-completion)
(setq org-outline-path-complete-in-steps nil)
(setq org-goto-max-level 2)
;; narrow to subtree when project is selected
(advice-add 'org-goto :after
            (lambda (&rest args)
              (org-narrow-to-subtree)))

;; csauer: use recursive percentage marks (from Org manual)
(setq org-hierarchical-todo-statistics nil)

;; csauer: custom TODO states and colors
(setq org-todo-keywords
  '((sequence "TODO" "NEXT" "WAIT" "DONE")))
(setq org-todo-keyword-faces
 '(("TODO" . "orange") ("NEXT" . "magenta") ("WAIT" . "brown") ("DONE" . "green"))
)

;; include archive files in clock reports
(setq org-clocktable-defaults
 '(:maxlevel 2 :lang "en" :scope file-with-archives :block nil :wstart 1 :mstart 1 :tstart nil :tend nil :step nil :stepskip0 nil :fileskip0 nil :tags nil :emphasize nil :link nil :narrow 40! :indent t :formula % :timestamp nil :level nil :tcolumns nil :formatter nil)
)
(setq org-agenda-clockreport-parameter-plist
 '(:link t :maxlevel 2 :scope agenda-with-archives)
)
;; Count time in hours on clock table
(setq org-duration-format (quote h:mm))

;; Only show clocked entries (no closed) in the agenda's log
(setq org-agenda-log-mode-items '(clock))
;; Show log and report by default in agenda
(setq org-agenda-start-with-log-mode t)
(setq org-agenda-start-with-clockreport-mode t)
;; Do not show grid lines in the agenda (1st arg empty)
(setq org-agenda-time-grid '(()
      (800 1000 1200 1400 1600 1800 2000)
      "......" "----------------"))
;; Columns to show in the column view
(setq org-columns-default-format "%40ITEM(Task) %9CLOCKSUM")

;; custom agenda commands
;; (setq org-agenda-custom-commands
;;       '(
;;         ;; org-super-agenda
;;         ("c" "Mega Agenda"
;;          ((agenda "" 
;;           ((org-super-agenda-groups
;;            '(
;;              (:order-multi (1 (:name "Done today"
;;                                      :and (:regexp "State \"DONE\""
;;                                                    :log t))
;;                               (:name "Clocked today"
;;                                      :log t)))
;;             )
;;           ))))
;;           ((todo "NEXT"))
;;          (org-agenda nil "a"))
;;         )
;; )
;;         (let ((org-agenda-custom-commands
;;                '(("u" "Super view"
;;                   ((agenda "" ((org-super-agenda-groups
;;                                 '((:name "Today"
;;                                          :time-grid t)))))
;;                    (todo "" ((org-agenda-overriding-header "Projects")
;;                              (org-super-agenda-groups
;;                               '((:name none  ; Disable super group header
;;                                        :children todo)
;;                                 (:discard (:anything t)))))))))))
;;           (org-agenda nil "u"))

(setq org-agenda-custom-commands
      '(
        ("c" "Custom agenda"
         ((agenda "")
          (todo "NEXT")))
        )
)

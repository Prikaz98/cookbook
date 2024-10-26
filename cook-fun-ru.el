;; -*- lexical-binding: t; -*-

(let ((p2p '(("Вода" 250 15) ("Гречка" 210 27) ("Дрожжи" 100 10) ("Кефир" 160 18) ("Масло растительное" 140 20) ("Мед" 320 35) ("Молоко" 250 15) ("Мука пшеничная" 160 45) ("Рис" 240 27) ("Сливочное масло" 320 22) ("Соль" 325 30))))
(require 'dash)

(defvar insert-instantly t
  "Write result instanly in the end of the line.")

(defun how-many-cups-ru (&optional product grams)
  "Look for in table product and return count of cups."
  (interactive)
  (setq product (or product
                    (let* ((choices (-map 'car p2p))
                           (selection (completing-read "Выберете продукт: " choices)))
                      selection)))
  (setq grams (or grams
                  (ignore-errors (string-to-number (current-word)))
                  (read-number "Сколько грамм? ")))
  (let ((product-proportion (-find (lambda (coll) (string= product (car coll))) p2p)))
    (if product-proportion
        (let ((res (/ (* grams 1.0) (nth 1 product-proportion))))
          (message (format "Для %d гр. нужно %.2f стакана" grams res))
          (save-excursion
            (end-of-line)
            (insert (format " (%.2f стакана)" res))))
      (concat "Не получилось найти продукт по имени: " product))))

(defun how-many-spoons-ru (&optional product grams)
  "Look for in table product and return count of spoons."
  (interactive)
  (setq product (or product
                    (let* ((choices (-map 'car p2p))
                           (selection (completing-read "Выберете продукт: " choices)))
                      selection)))
  (setq grams (or grams
                  (ignore-errors (string-to-number (current-word)))
                  (read-number "Сколько грамм? ")))
  (let ((product-proportion (-find (lambda (coll) (string= product (car coll))) p2p)))
    (if product-proportion
        (let ((res (/ (* grams 1.0) (nth 2 product-proportion))))
          (message (format "Для %d гр. нужно %.2f столовых ложек" grams res))
          (save-excursion
            (end-of-line)
            (insert (format " (%.2f ложки)" res))))
      (concat "Не получилось найти продукт по имени: " product))))
)

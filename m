Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A7671A070E
	for <linux-modules@vger.kernel.org>; Mon, 23 Sep 2024 18:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727115550; cv=none; b=sOMWyBjSW/jvCxYFm4DKkK8zBdU80egFsRHZjudS9mv0WxP168w66/DRTiPSHgb7DAJ//sPIN5GshcoyfCGCGbUvHL8Y51xnraBXjN/q7On4anMK6bpBrOZMtOBXhk/am+LqHrceIAd79b6kOEAA56FJ+hUVrRUJCdndR+5UjJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727115550; c=relaxed/simple;
	bh=oXNzm4MZb0k/XXfQMZMx6410zG4bTNO8FdzpKDFiStc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CqCn0GYJUnAuOtWcpJF20huszQy34CG5g14BpE1zMnI4r/x1GqzEXJQOv3NJ5TI3yxeU5blmwq2CvG+66HmywuQM/8OJTYjQVxlJNrVePIXgRe6F3klFEnIu72SH+HME1HKSnfWCwYbZo0xPRtKgInuybXT+mVXwM7xjmlgrgws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VRVB5urv; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VRVB5urv"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6dbffbae597so77885237b3.2
        for <linux-modules@vger.kernel.org>; Mon, 23 Sep 2024 11:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727115547; x=1727720347; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7d86bJdCRGCypNEWHvJnM+7Kig6RbYD9GxfCLKVtKPE=;
        b=VRVB5urvPjGP3zha/Hv7jptCgmXOto7ufx3KghcIIDTbHo2ZsXLPvVgbu9WVKWYGes
         Rkd1/1nNmRjsQkz04gabvDbs35b7HeyCywxp6THtswN4iz8LmhmORpOsAHihy6czQfd1
         ys4JxqAfKzsqhgrRBPQa8hj7VxJfWHfIuPAoExoI9SKzXGSbuGwPrAD8aw9pUgPpl3Nw
         CJiif3qm3gVZkOhFFVaf//PynTCt/YjouDuquTblhJdoSSIfKe+K7I8aXYuxONZXESan
         7sXY4EKR1YRacWHbBS6ayE6n5Kr9qtT07hBQZrTGeZm7azvpzsvpErKBCgA85cg3gJSb
         xr+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727115547; x=1727720347;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7d86bJdCRGCypNEWHvJnM+7Kig6RbYD9GxfCLKVtKPE=;
        b=Sf1L/fSrj5gJo8hvt1OBcwiFwJSQAKmGw5nZ4pGr5KMLtykG8CoqNskYsks67tRID7
         FB6exby3kGwHeoSZOGx61W3nyF3YE730/LU0XmCLXBYDkNWKKtlRHBNqe/ki79QGNeWk
         GxcyU272WghPw2YSxdsYOSGXLOC/2vxv0+qphA8PaRgtEM6tjTvHxwMfetAV2SryRDXS
         xz4GM/x9QreRqsxG7jziXiwXR+SzpbsPLQ5wDM5hEuU9UdFGe+25HsC2k/QSjSMTs7fh
         xyDJeBtgpAyxUshfeSab5dzV/N4UbJJEwi8wMJuuYsMmAP7wSDqr34TiUvNE4yWpYcpQ
         Kw/A==
X-Forwarded-Encrypted: i=1; AJvYcCXGydCL+aZBohjjs6RIGU2B+PdoTMagzIeySdWziYYk2VZvWyupUtIKv/Z8u2Qp3vv6A0HVttseGkESKjzi@vger.kernel.org
X-Gm-Message-State: AOJu0YwNffM1nS7IWPrkVaxaMHgA/ip7vzbwEl3fwTYlTKZWUW1SOSF/
	piUV8i15SWD5nx/+iZCjxxSFM+HajdjoKrRPrKsES5UXPiUknMFlRtd6FkZ9YG/U+Vtcft+SMC4
	nan2nwfhL7KLxqCT0ka5AQVAgDg==
X-Google-Smtp-Source: AGHT+IHm2Anof1qGJ9R1CvWT3pkt5SNmdiVkAOQ5LZRBMwdvknPsZ+Wqwa1ekbtEl+NQeccCrcS1Kq2JDKfyTFFeZVE=
X-Received: from samitolvanen.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:4f92])
 (user=samitolvanen job=sendgmr) by 2002:a25:690e:0:b0:e1d:21ae:3b95 with SMTP
 id 3f1490d57ef6-e2252fe2127mr32035276.10.1727115547235; Mon, 23 Sep 2024
 11:19:07 -0700 (PDT)
Date: Mon, 23 Sep 2024 18:18:47 +0000
In-Reply-To: <20240923181846.549877-22-samitolvanen@google.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240923181846.549877-22-samitolvanen@google.com>
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=2207; i=samitolvanen@google.com;
 h=from:subject; bh=oXNzm4MZb0k/XXfQMZMx6410zG4bTNO8FdzpKDFiStc=;
 b=owGbwMvMwCEWxa662nLh8irG02pJDGkfN7IpMgaalZt/ZdNgMn5hGFUwv/f5BSflZZ//L7YV2
 au9/cPfjlIWBjEOBlkxRZaWr6u37v7ulPrqc5EEzBxWJpAhDFycAjCR3leMDFfk1WPEjs9IzO6Y
 ry/OH+RzXaBp+eTWuw8rJO47lKz1us/wP0xmVZtejIrC77VzTjnVp3f196efPWzpckN52UR/ucQ 8DgA=
X-Mailer: git-send-email 2.46.0.792.g87dc391469-goog
Message-ID: <20240923181846.549877-23-samitolvanen@google.com>
Subject: [PATCH v3 01/20] scripts: import more list macros
From: Sami Tolvanen <samitolvanen@google.com>
To: Masahiro Yamada <masahiroy@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Matthew Maurer <mmaurer@google.com>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Gary Guo <gary@garyguo.net>, Petr Pavlu <petr.pavlu@suse.com>, 
	Neal Gompa <neal@gompa.dev>, Hector Martin <marcan@marcan.st>, Janne Grunau <j@jannau.net>, 
	Miroslav Benes <mbenes@suse.cz>, Asahi Linux <asahi@lists.linux.dev>, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"

Import list_is_first, list_is_last, list_replace, and list_replace_init.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 scripts/include/list.h | 50 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/scripts/include/list.h b/scripts/include/list.h
index fea1e2b79063..8bdcaadca709 100644
--- a/scripts/include/list.h
+++ b/scripts/include/list.h
@@ -127,6 +127,36 @@ static inline void list_del(struct list_head *entry)
 	entry->prev = LIST_POISON2;
 }
 
+/**
+ * list_replace - replace old entry by new one
+ * @old : the element to be replaced
+ * @new : the new element to insert
+ *
+ * If @old was empty, it will be overwritten.
+ */
+static inline void list_replace(struct list_head *old,
+				struct list_head *new)
+{
+	new->next = old->next;
+	new->next->prev = new;
+	new->prev = old->prev;
+	new->prev->next = new;
+}
+
+/**
+ * list_replace_init - replace old entry by new one and initialize the old one
+ * @old : the element to be replaced
+ * @new : the new element to insert
+ *
+ * If @old was empty, it will be overwritten.
+ */
+static inline void list_replace_init(struct list_head *old,
+				     struct list_head *new)
+{
+	list_replace(old, new);
+	INIT_LIST_HEAD(old);
+}
+
 /**
  * list_move - delete from one list and add as another's head
  * @list: the entry to move
@@ -150,6 +180,26 @@ static inline void list_move_tail(struct list_head *list,
 	list_add_tail(list, head);
 }
 
+/**
+ * list_is_first -- tests whether @list is the first entry in list @head
+ * @list: the entry to test
+ * @head: the head of the list
+ */
+static inline int list_is_first(const struct list_head *list, const struct list_head *head)
+{
+	return list->prev == head;
+}
+
+/**
+ * list_is_last - tests whether @list is the last entry in list @head
+ * @list: the entry to test
+ * @head: the head of the list
+ */
+static inline int list_is_last(const struct list_head *list, const struct list_head *head)
+{
+	return list->next == head;
+}
+
 /**
  * list_is_head - tests whether @list is the list @head
  * @list: the entry to test
-- 
2.46.0.792.g87dc391469-goog


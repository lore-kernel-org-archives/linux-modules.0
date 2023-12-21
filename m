Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B1285821D
	for <linux-modules@vger.kernel.org>; Thu, 21 Dec 2023 16:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BaSqGs76"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703177939;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=YfzgPU3MkfaqMkHywTBvwxBqqqhijQZYQX1JEq3yLos=;
	b=BaSqGs762xxaBKLh8zl0g+GTMPoiR2NxJ6iMau8Kjs2jpGGjNiQrEUSgZtZBxF/bEezK0o
	4TABIiyLvAROtZsksiIVACQxknv+lfmNaKBCjFZ8qggHtq1E/qh4lo+mP8LvDBX/1BQvsJ
	Sav72rQdrtmy9p2s5UZu/V6J2c/dvTA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-235-LyKNAesXMImg6FjRBwwrvg-1; Thu, 21 Dec 2023 11:58:57 -0500
X-MC-Unique: LyKNAesXMImg6FjRBwwrvg-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-33667220256so691846f8f.3
        for <linux-modules@vger.kernel.org>; Thu, 21 Dec 2023 08:58:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703177936; x=1703782736;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YfzgPU3MkfaqMkHywTBvwxBqqqhijQZYQX1JEq3yLos=;
        b=qKDMJjPfTpWmmhY5BUBcG53ZM+9970MIABTuvVtSzYdrsbtpwQXgB/WPR/8WcDCWf7
         jk/Pqct8yJ3j8c9U0ZXohInIVa9UTeKU7WqsN75y5gOg11vDICFKrV7iVfquXGBjVinG
         5deRA97wlnQzX6SRqFyMoRvrKt/bZjVLjAWL733Y0HWLtg2jaceq2HsOdkNp3KKR7jfd
         iHJMIzFpU1cwcchdvL4wpZ7cXko1iuEMjBIl+sHGtEz89FfRD9PxpnX7u9RBoL9xyoA+
         /JLfUydWScUuK4kLQyWZDeI3LVOHzpTdmx0ThijBt2VqGFaNt+Ega06h7TjS+/3ZCTne
         kjxQ==
X-Gm-Message-State: AOJu0YxIaJZ5bPPN+GMPl9xrwpjShvGZ8zi9ALFyW0sWpXEvOluP8G2a
	PtQ8ZEhEQMWMIvVqoK54F9M3l7Yg4a272ubUUBoWYn4Fp/MDswVyyscxjOSF4EctShTKa/eNIpQ
	X/5IbVhM9QAm1XELX62aOUf8Mm1OyHENG
X-Received: by 2002:a7b:c8d7:0:b0:40d:3bd1:3dc9 with SMTP id f23-20020a7bc8d7000000b0040d3bd13dc9mr2461wml.219.1703177936729;
        Thu, 21 Dec 2023 08:58:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEbByqWtAWAPFMSK5jVspKSO6YeLOYJty6KrgKSNfnZjI5LmzBWOfBm3dl7JgTsSMglSsII3Q==
X-Received: by 2002:a7b:c8d7:0:b0:40d:3bd1:3dc9 with SMTP id f23-20020a7bc8d7000000b0040d3bd13dc9mr2454wml.219.1703177936454;
        Thu, 21 Dec 2023 08:58:56 -0800 (PST)
Received: from klayman.redhat.com (net-2-34-31-72.cust.vodafonedsl.it. [2.34.31.72])
        by smtp.gmail.com with ESMTPSA id v14-20020a05600c444e00b0040c58e410a3sm11874745wmn.14.2023.12.21.08.58.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 08:58:56 -0800 (PST)
From: Marco Pagani <marpagan@redhat.com>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: Marco Pagani <marpagan@redhat.com>,
	linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] kernel/module: improve documentation for try_module_get()
Date: Thu, 21 Dec 2023 17:58:47 +0100
Message-ID: <20231221165848.150041-1-marpagan@redhat.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The sentence "this call will fail if the module is already being
removed" is potentially confusing and may contradict the rest of the
documentation. If one tries to get a module that has already been
removed using a stale pointer, the kernel will crash.

Signed-off-by: Marco Pagani <marpagan@redhat.com>
---
 include/linux/module.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/module.h b/include/linux/module.h
index a98e188cf37b..08364d5cbc07 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -668,7 +668,7 @@ extern void __module_get(struct module *module);
  * @module: the module we should check for
  *
  * Only try to get a module reference count if the module is not being removed.
- * This call will fail if the module is already being removed.
+ * This call will fail if the module is in the process of being removed.
  *
  * Care must also be taken to ensure the module exists and is alive prior to
  * usage of this call. This can be gauranteed through two means:
-- 
2.43.0


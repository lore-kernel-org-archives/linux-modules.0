Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 317863115BD
	for <linux-modules@vger.kernel.org>; Mon, 13 Oct 2025 15:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760369991; cv=none; b=mEh2jBToNnU+SZKJ0amfvUYGYUewm8DkZfgc5IMEozLAfoWWqdpZnzPfOYAYPIfcSJlZWgnqlGmuBcsap60GKtGDGPQkjOVbyRbxPHtLMUOq6L8x34zewL1854rb5+MVfrxD/QCTDQgYasJwcLGeRfGcZ/wF0EfIqBaszlYIfwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760369991; c=relaxed/simple;
	bh=mUdyWiaMtVvum5RTj9ic5YSdMHipXTsRvWK4ObexLVs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=RvPwlcYm0WnLM7+htWDzX+EiTB9lzkFGnQLhWXwJTyynyxhpIuQQL6AWQGarOe6MBe81Gif5gcvcHf/oXE+/OEePXKw5BKVQC9ayC2A4ldUSFzMt+J5j3CqXctUczLJCiVRFpl1lM0QNliCZxuEQfaOYRItwAO3oANbRGG8cGB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sidnayyar.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KjgXCWRq; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sidnayyar.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KjgXCWRq"
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-3ed9557f976so4420233f8f.3
        for <linux-modules@vger.kernel.org>; Mon, 13 Oct 2025 08:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760369987; x=1760974787; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=l8l5v6qiimGPtv9u5QonCWzpEhlvJ98SCHb4SgKDHVc=;
        b=KjgXCWRqzLtxqtRGkyFp1OT/ckSaASJ6feu6CqLLa/He/M07ri4tWczTjjwiLGB/oL
         fBxPi/o4LQGx/QIoE78VYtEJfqMze/+zX9ga8bu2VUSWCUtQ1VjNQKlGwy4UbI1zkYZ4
         HoIPfLQJfZZ78yjiLNTCBwZfLr28L3+buKbY8vl0ZS8JlmGLD3pXDeMBof8TO2sZWyze
         JrUYR1C+CknKMyFkiVWM+yXST235jYdvNZpbclvhHgQZM5J0bT05/nWqAv8DdaQOt84U
         5iOw4ZAYGXFh8SyAR6orNaqVxy8fRA+tvc51ybgY2Ic1+/zO1o429sdhGwwq6y6+V9c3
         IUrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760369987; x=1760974787;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l8l5v6qiimGPtv9u5QonCWzpEhlvJ98SCHb4SgKDHVc=;
        b=sWCx4MBOfKNxixlg8emvo72Eu+rpQtbkEwXT5BDm8P4XjYomyC5+zqA3Qp3b7VzV3a
         wpnY/fDgYFdByIL5ozOCqQXvxr7hI0aCWMKhO6wENqkGDCpw4O7U7e1dOEH5GVNjSlZk
         P4eaLnwEjdOZhbnJO6+hdQm+cgS2MkX3RqHbNNWPTiK0jzuWuNFFOpptC5uTfjU2hVpT
         MXKR1Bp4sw3yFuji6UpcxcFfCju5LPPyZHriQ4nWtTU1jkxSU0MZUA/q7yhdfFmcaswZ
         GDOFHLt5OXJboYZCqBDqwieSJSjw27XUGPu+dNcC5tPZbj1p5wIs/zOHTJ4vT+SXGZ6I
         riHA==
X-Forwarded-Encrypted: i=1; AJvYcCUpKzt493WQnxeUiDfAJP2snj/Z7rPip1CcPH8m5JNIQSHjLQ0hsizr7Ug9trPg59eKrpqlu8jslBagkDVY@vger.kernel.org
X-Gm-Message-State: AOJu0YxFYptQCkwKvflzwk5JdYM3ikdLnpfQvKN6KGxD5KLBYwkdtTlw
	a9KK4B0D6qKDZh+zGOqUX5QSiZ53xoizY3qfaRVQ9wFuVTQ4+rLf7WinSjcKaeNArPL0eKFGRMM
	Rq9l+13huzzs/k3MWCg==
X-Google-Smtp-Source: AGHT+IH1j8tUfipQWeFaA8XhmoFYMLY/hNVnlYfVWyuGOekLQXj/Amrxq8GIzS8vIR8WKDj6T3Cvmmf/SjVMboU=
X-Received: from wrmp8.prod.google.com ([2002:adf:e608:0:b0:426:d630:53cb])
 (user=sidnayyar job=prod-delivery.src-stubby-dispatcher) by
 2002:adf:e18a:0:b0:426:d54e:81a4 with SMTP id ffacd0b85a97d-426d54e81b9mr6525079f8f.56.1760369987644;
 Mon, 13 Oct 2025 08:39:47 -0700 (PDT)
Date: Mon, 13 Oct 2025 15:39:09 +0000
In-Reply-To: <20251013153918.2206045-1-sidnayyar@google.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251013153918.2206045-1-sidnayyar@google.com>
X-Mailer: git-send-email 2.51.0.740.g6adb054d12-goog
Message-ID: <20251013153918.2206045-2-sidnayyar@google.com>
Subject: [PATCH v2 01/10] define kernel symbol flags
From: Siddharth Nayyar <sidnayyar@google.com>
To: petr.pavlu@suse.com
Cc: arnd@arndb.de, linux-arch@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org, 
	mcgrof@kernel.org, nathan@kernel.org, nicolas.schier@linux.dev, 
	samitolvanen@google.com, sidnayyar@google.com, maennich@google.com, 
	gprocida@google.com
Content-Type: text/plain; charset="UTF-8"

Symbol flags is an enumeration used to represent flags as a bitset, for
example a flag to tell if a symbols GPL only.

Signed-off-by: Siddharth Nayyar <sidnayyar@google.com>
Reviewed-by: Petr Pavlu <petr.pavlu@suse.com>
---
 include/linux/module_symbol.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/module_symbol.h b/include/linux/module_symbol.h
index 77c9895b9ddb..574609aced99 100644
--- a/include/linux/module_symbol.h
+++ b/include/linux/module_symbol.h
@@ -2,6 +2,11 @@
 #ifndef _LINUX_MODULE_SYMBOL_H
 #define _LINUX_MODULE_SYMBOL_H
 
+/* Kernel symbol flags bitset. */
+enum ksym_flags {
+	KSYM_FLAG_GPL_ONLY	= 1 << 0,
+};
+
 /* This ignores the intensely annoying "mapping symbols" found in ELF files. */
 static inline bool is_mapping_symbol(const char *str)
 {
-- 
2.51.0.740.g6adb054d12-goog


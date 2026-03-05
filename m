Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12CF53DEADE
	for <linux-modules@vger.kernel.org>; Thu,  5 Mar 2026 16:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772729681; cv=none; b=KlJBicUWGQdncNTxFqIJACzrMJTJtSRVNCFrSVCB2zFjHGD6b+/u3okofvJjYV2c9UbzTbF7Gl6U8Bza5fDqLXfJucfwtMstMp0wNbjIM1a30FV8Q8GXcuRg18kvDma4LSy0D5g5GZv3FdDAAUehmafp1p+2TmeS+k6A4R9Q5Hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772729681; c=relaxed/simple;
	bh=/LRjn4DsKeVQZ4dzyANbTGqQ6W2rGj3js9YDFwrFWZI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=l29tsXOkbQZt89ui5i/D1Y84I4RLjNy8E8V0zDm/asvHqDVk7vMXWokHVm+D8ypkU7NLR9tN8l9ZHcHA3DZfZamx+rUSj7Bu3cmvTHH2OEpHqbHjp7a+OcYD1h23XsWupQTxfE1wkhifnMlMm3L4QkXGOn0I2iH9jYYO4jrCo9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sidnayyar.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GFx8dS3R; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sidnayyar.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GFx8dS3R"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-48372facfedso72055595e9.0
        for <linux-modules@vger.kernel.org>; Thu, 05 Mar 2026 08:54:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772729677; x=1773334477; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=uMu0xUqSjGdHKDTYMSydPkunIn5YCF8kNNeiDqHV0Wk=;
        b=GFx8dS3RPhRQrd8aEAhWoi8w6LrKqygyG9nnbjZDMVXKQd8vQI8w7O2rgm2mfo2RMA
         qwz6IApjkhEW6/xbjIVcnr4ZB3GjVsM+91O63iEhR/yz3On6iaJ8VBKZSMrSs8hR7Qel
         OKM5mY5jW/xXmciE/wschWdSOzaAx+obbzyMQITA5FLdmaHG7vSg/czlTcj9yCKeYXI1
         2Iwuy/npohzCkrmxSFrHjVDPWd8zRcBVCSFT2V6YWMg3O6aH5HEbEvFEA3BGHfGnl3Rv
         VAs70FKibOzA1r1k6zgMjt+yaPmP78rbNHLhWYvSXIFHbIM0kXVW+UcmJxWtCWePeDRG
         sb/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772729677; x=1773334477;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uMu0xUqSjGdHKDTYMSydPkunIn5YCF8kNNeiDqHV0Wk=;
        b=GrGTmlrmgP2qT/MWfkfrmGwfvZELqprGUt8MhOATJJ3fM78UP9uuGUbCXL3pcWK/lb
         /vsRUJ5u/sGaQ4+HDWhiBBrPJU6DLMmryCZQWiny3qOQ46Ml5pBGG+31YRh87FtAbAIu
         mcfzwH656IxtnpYt1CWcBWTsnNMiEk89pLs0qtxuc5Yeni7Y+GS+KyZXJXQGLqCCI/6X
         8Yr1EnXTIw7lbbF4cVDXQzSbvp+tEDM7jwChhqXwLmb90Qdo/w4EfZjZkUJNAytMDMR7
         s6l57r2wJ6BIksa+XOwVL8ieY7tLy2XHK5gTm2yg5a3aJuVw4Sh1K2DiTQ9npmNYDyav
         sTNw==
X-Gm-Message-State: AOJu0YwQZ6u4dr3dsnbGuKnKbKwRvu2x+ZsUyulvaXoBXXKHKt/WmNaj
	BTIDgHBs4IgS8A8OC95hFBajYgGxMVlDJMIYRGDG3a4jjBoP/bvlak4qZFnGg3ZwcvEeIeonINh
	TALcMLPAdr25a5ZvcDg==
X-Received: from wmqi19.prod.google.com ([2002:a05:600c:3553:b0:483:6fe1:c054])
 (user=sidnayyar job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:5397:b0:46e:59bd:f7e2 with SMTP id 5b1f17b1804b1-4851ee93bdfmr46394685e9.11.1772729677377;
 Thu, 05 Mar 2026 08:54:37 -0800 (PST)
Date: Thu, 05 Mar 2026 16:54:28 +0000
In-Reply-To: <20260305-kflagstab-v4-0-4fe6eea27e30@google.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260305-kflagstab-v4-0-4fe6eea27e30@google.com>
X-Mailer: b4 0.14.3
Message-ID: <20260305-kflagstab-v4-8-4fe6eea27e30@google.com>
Subject: [PATCH v4 8/8] documentation: remove references to *_gpl sections
From: Siddharth Nayyar <sidnayyar@google.com>
To: Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
	Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
	Aaron Tomlin <atomlin@atomlin.com>, Arnd Bergmann <arnd@arndb.de>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>
Cc: linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	linux-doc@vger.kernel.org, Siddharth Nayyar <sidnayyar@google.com>, maennich@google.com, 
	gprocida@google.com
Content-Type: text/plain; charset="utf-8"

*_gpl sections are no longer present in the kernel binary.

Signed-off-by: Siddharth Nayyar <sidnayyar@google.com>
---
 Documentation/kbuild/modules.rst | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/Documentation/kbuild/modules.rst b/Documentation/kbuild/modules.rst
index d0703605bfa4..b3a26a36ee17 100644
--- a/Documentation/kbuild/modules.rst
+++ b/Documentation/kbuild/modules.rst
@@ -426,11 +426,12 @@ Symbols From the Kernel (vmlinux + modules)
 Version Information Formats
 ---------------------------
 
-	Exported symbols have information stored in __ksymtab or __ksymtab_gpl
-	sections. Symbol names and namespaces are stored in __ksymtab_strings,
-	using a format similar to the string table used for ELF. If
-	CONFIG_MODVERSIONS is enabled, the CRCs corresponding to exported
-	symbols will be added to the __kcrctab or __kcrctab_gpl.
+	Exported symbols have information stored in the __ksymtab and
+	__kflagstab sections. Symbol names and namespaces are stored in
+	__ksymtab_strings section, using a format similar to the string
+	table used for ELF. If CONFIG_MODVERSIONS is enabled, the CRCs
+	corresponding to exported symbols will be added to the
+	__kcrctab section.
 
 	If CONFIG_BASIC_MODVERSIONS is enabled (default with
 	CONFIG_MODVERSIONS), imported symbols will have their symbol name and

-- 
2.53.0.473.g4a7958ca14-goog


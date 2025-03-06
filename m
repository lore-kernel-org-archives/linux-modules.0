Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F99E20E71C
	for <linux-modules@vger.kernel.org>; Thu,  6 Mar 2025 13:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741266932; cv=none; b=LexEwzzIxHK/znFomXdM0lR8Ed+N6AUAbxiGiMG4a2KrOd6IdYyNOprEg4G6g3YYhw1GKOdxWIuGloPqEfsSL6hMu/CFWgU2FT/xVK8sct0XFmQgcEXt/6u1l+G5XvCxYLbD8yASu9OzcA+NFxiwx6G0qD3XHNKWNMs49icG3mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741266932; c=relaxed/simple;
	bh=t9WUE4puJ3y/u1gPad4p78vEDZXVaqsDCLjaQIolUf8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Lk5M/bxv5ERJgemo9WFNdHCsI5DluNAWOqM60Sxdwox8zn4qyAy1czYr6rvECgjFBIwUP8MM1ummWrNatDFe7rUFd0SaISLAEtRbJd4Mz2lURH1xpGe7cfhsnd8rQdfxEeN6s4xMY/WRGcAAt+4DN30TH+bUkiOr8UT3IyHa2q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=MIeD1qum; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="MIeD1qum"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4394a0c65fcso7086395e9.1
        for <linux-modules@vger.kernel.org>; Thu, 06 Mar 2025 05:15:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1741266929; x=1741871729; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XvqE0gdDd8D80g4QcmunzIAXwiMoEWGi2ibgkUreq8w=;
        b=MIeD1qumAArSC7exNSs3ricWz+59+FCdxDfnEWtDCTePJDnI2b8j+IVFztpSUT+5o7
         zU1OFfJ8wFcq9M3b3mAnLERCVtfIhOW3ajlyyxGCNAuPx6mV3Now0cD4vFzNjuD0KgOw
         loU8sPfamk/6xZ0qp66b25HGUSPXODtHmwZhWgX8c08zAjb5FCwkMB8wJeaqWFsEGTem
         eJU/JYPmSGBbIlp6FIGydP+Malk8xxCrc7tOFAp/ojh5fejmq0x9+9ox9zG7B1Ri7jqJ
         MHWekudtOYYwzjDlNnuq5BM4l4TbNuusFD6kEFHL5qKRcTNFnEZsoGNAIDSFC2KifrVP
         dW2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741266929; x=1741871729;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XvqE0gdDd8D80g4QcmunzIAXwiMoEWGi2ibgkUreq8w=;
        b=UFKx789SvTMat1rxbpPjL8N3+dxmJoOZkIS9cxkbworWhs4qYGV8k0zYDfJclXvVE0
         wFdG5gXUxkwJZsk1hYYqu/YWRJzL7EbYbJTemu+pCiY+ap6nV1TaXS6jwbO3y6hUB565
         4shxB3JU4EB0NJp7iS7HgcJ3H6fkqC4K1U3AvgcxnXU6rdYWjQiziwgwX8ynsuGk/Xyf
         /DZG90bJ2jJrzK7fR9SxgAnCgiw9QUQjRt6FzdQwK9zcgEliwy4mEjcZCqKfB+dm1ueo
         TQPdHKVV6T6jwnp6IFR9o7hwTnTfTSg6kJPzRxpuxblL7qIuofs2MToaetEYvniGplX6
         j1WA==
X-Forwarded-Encrypted: i=1; AJvYcCXC6xJ4xUPBnYQ9vcfUCMGb9Cd5aWuaIz5y6hVaL9nM3SA4FFSoZD0RnrKk+FgpuKtTMWWaIS5bAgBCPic/@vger.kernel.org
X-Gm-Message-State: AOJu0YwgmZi9XhipePSwDeS3q7bT0ivW8wN1a8wMIPcknzO6S2lcO8il
	ahUwEMdplCET4pz8mg/9o/cb5hU+RdnzdsKZdT4gqfv5kjgAMva8SilZz/9D+Tg=
X-Gm-Gg: ASbGncuPtpMreATnKLKkl5ztJaQfpmyjU5QsW9CNl9vaYYih+ntVBh9s5YLkFd+Q/wd
	9WuuRgbzrSygFIapQ0EljyAeiQQaVHNA/hHzrClms2pcQckr2gMQjyKuTQDqvdP54PR2nslUuIL
	9hHVFx+pmZrv16A4V89bGMN9PrL3JRpMvRgWglKbnGn18WoM4w72v9GxdaghLL1lMwSual3wW2W
	kKGuGVDAQ2EZxDXpUsU8RVhumkk/hCqDv9Qfcgs7AFq5QZ9iMZVR+QfTmABFRyZnWeUAVy8ITom
	MYnOPXRhWSYfKEP44v90kzmtflAUsa8zjyxCgRXTS0km/HL1
X-Google-Smtp-Source: AGHT+IGN9G2IHEnZL3cvPtt7JMOOBNRM/b0RxlvzKWb5wGb0QePNN3COkLKHXonQaY7+rv3elRBeMQ==
X-Received: by 2002:a05:600c:4f11:b0:439:916a:b3db with SMTP id 5b1f17b1804b1-43bd292fee0mr67965375e9.6.1741266928699;
        Thu, 06 Mar 2025 05:15:28 -0800 (PST)
Received: from dhcp161.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43bdd8c327fsm19704485e9.13.2025.03.06.05.15.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 05:15:27 -0800 (PST)
From: Petr Pavlu <petr.pavlu@suse.com>
To: Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Jason Baron <jbaron@akamai.com>
Cc: Sami Tolvanen <samitolvanen@google.com>,
	Daniel Gomez <da.gomez@samsung.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] module: Make .static_call_sites read-only after init
Date: Thu,  6 Mar 2025 14:13:51 +0100
Message-ID: <20250306131430.7016-1-petr.pavlu@suse.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Section .static_call_sites holds data structures that need to be sorted and
processed only at module load time. The section is never modified
afterwards. Make it therefore read-only after module initialization to
avoid any (non-)accidental modifications.

Changes since v1 [1]:
* Rebase the patches. The kernel now has commit 110b1e070f1d ("module:
  Don't fail module loading when setting ro_after_init section RO failed")
  which addresses a previous problem with handling ro_after_init sections.

[1] https://lore.kernel.org/linux-modules/20241223093840.29417-1-petr.pavlu@suse.com/

Petr Pavlu (3):
  module: Constify parameters of module_enforce_rwx_sections()
  module: Add a separate function to mark sections as read-only after
    init
  module: Make .static_call_sites read-only after init

 kernel/module/internal.h   |  7 ++++--
 kernel/module/main.c       | 18 +++------------
 kernel/module/strict_rwx.c | 47 ++++++++++++++++++++++++++++++++++++--
 3 files changed, 53 insertions(+), 19 deletions(-)


base-commit: 848e076317446f9c663771ddec142d7c2eb4cb43
-- 
2.43.0


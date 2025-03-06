Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AA0220F073
	for <linux-modules@vger.kernel.org>; Thu,  6 Mar 2025 13:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741266937; cv=none; b=iHhSNtxYujPX4i1/9TcopiBduLP0xX/9sGZzGYeaNzzEVlfbxMC+z6ys6Ql67vzzKJTTcsWhkV4y4RVfg5gIlv/28MLNl85eZjlVJfufUUzYiCEvE0LiEUe16xJFgC9kuxmCkzpNTDPIv7jfwO8cwq0cVw1ORhALT0Jmel/AcwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741266937; c=relaxed/simple;
	bh=sqdytAodsHq9QNCvtIZ+Zn5N0QYNPXaH3EIcLQ+sw0Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NYZuRP23zR29x5D7yBgFXhqMF8PIn14nn9Ur+Wyc2Y4jdvpA6FeDCOMw3DsAkdUpX3YF49/ZgYa7Z10Eg+kCIonEXihQW1q7Nf7xP/atfIJChdYjX+wxb0iq+lpfELsYO4mde5OwtkN77qqG2q+7wemvxsyh9x7lPi2k+8B7hEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=LgpclZZj; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="LgpclZZj"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4394036c0efso3726005e9.2
        for <linux-modules@vger.kernel.org>; Thu, 06 Mar 2025 05:15:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1741266933; x=1741871733; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2F56/bXpgvW/PQd4WvaaCrrA3/3M+CJr+Y5MI4QmHaE=;
        b=LgpclZZj3U0fINsuUb75w886HF7sCDLRA8wccWhTlLz++4I+gh61laBhNJlzfGhyVj
         dnXyn2rAHluoFTus9o+30f/JaoTBE+CoZqFMDBQTkDAqJTfjqAUJq/q9d2az1u1QqMx2
         xvbwAS6+tOGPxwh+/PbwlV2MkQWY1Zm51HC3m31Cj6snBoCxd8vLxRm4WduMNHoiWa/S
         O7flxjnMSZLyKbTw62nsLP9/QTrY/TyrViNioznuVqp1rrp4Oo7Y1nsaz0LCIF3udDAM
         i/HDxR8c0pOrdViAgJUPfLAXIjLhpJhfRRm0By6bS65QsS4a0Nq4DDzSA6Szjj9saQ3P
         80WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741266933; x=1741871733;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2F56/bXpgvW/PQd4WvaaCrrA3/3M+CJr+Y5MI4QmHaE=;
        b=mojDL+DYlpbGIVHvqVGiKWMl+OMs3HRzJdAwj5KUmvkVDYDAwKezlmYcAp3vctsAfB
         LdR17ZxKs8VGPfd45duD5VV1pXER69wHRm4laB3GdjmDFTMu0Ko4gTlb5jqnIkBiDVP8
         ua7sUr8z13WTZEjvU5NUrfbvdqTXKnXGTqbh6ej0EWoRCYvkK1ZCeQIq3lo25d+/IP+Y
         5ZVCgn1xkY6LfVOk+F3xHxFSOflQPXxeIclTmOPqNGHWaY77gm05qXprBSZMUSNsydAF
         TsslTM3UpyJIYTS1yMkaFp/Q/46mDbYEUOOfyy7kETZwwfFZzL64BaBbFimVrXcYDwv+
         S3eQ==
X-Forwarded-Encrypted: i=1; AJvYcCWJ4PMY2AqDWJGFNvfCKTruPFNiioj+KjZ4wMy7YRI489NQTJb3ldha62qzbCMQytdSO7BJdueZvcVkkX+h@vger.kernel.org
X-Gm-Message-State: AOJu0YxMZUQgqAmzOL+4xumiENJUzWG+h/mu2GBnJJc+3xDebEVmZ0x7
	QmhieiKs/Xr02CgSZeKnJSOgPpFUxuvQItvfr2HCcLIp+eyX6rRSv+4DJeu+VoM=
X-Gm-Gg: ASbGnctUFe6rhl/gY5gKnJBgX8GJLoUB9+KB6dOTGt+YbqYLKi5LriDevfXxNQrrphP
	m609qP2qNVFi6OwNN0oac8vKfYu+tSFNpLX6mApFou9jg4VsnMeDFctR4MK2QpZ48z7XX4Q9md1
	JZ1w3FphwNHs+/V1O9KiAWZ5OsuIdTaiDFtX9Eexew8uZLS2zW+/7xW5zJ+wkBaBrHqyKRBXRf7
	GRfde9dQEaHyZQt/UiEsWiX3lu2ooXKcRd+b1VUT9jw0N+Kj8R5OjEW+ahloeMhHBQX4XQoa5Zv
	h1ZnXdKYWtn7u1VUoZQVPAiVhqQmz+nKNLdWFByp9LlQQtFW
X-Google-Smtp-Source: AGHT+IHOyulRWsRbaL8sagZbBUzdBihh8XWqd70FOnBN7LQrsvkLlJuS76NdiPbsbr5xA7z7M3wvvQ==
X-Received: by 2002:a05:600c:1c29:b0:43b:c94d:e200 with SMTP id 5b1f17b1804b1-43bd2929948mr46520145e9.1.1741266933457;
        Thu, 06 Mar 2025 05:15:33 -0800 (PST)
Received: from dhcp161.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43bdd8c327fsm19704485e9.13.2025.03.06.05.15.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 05:15:32 -0800 (PST)
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
Subject: [PATCH v2 3/3] module: Make .static_call_sites read-only after init
Date: Thu,  6 Mar 2025 14:13:54 +0100
Message-ID: <20250306131430.7016-4-petr.pavlu@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250306131430.7016-1-petr.pavlu@suse.com>
References: <20250306131430.7016-1-petr.pavlu@suse.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Section .static_call_sites holds data structures that need to be sorted and
processed only at module load time. This initial processing happens in
static_call_add_module(), which is invoked as a callback to the
MODULE_STATE_COMING notification from prepare_coming_module().

The section is never modified afterwards. Make it therefore read-only after
module initialization to avoid any (non-)accidental modifications.

Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
---
 kernel/module/strict_rwx.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/kernel/module/strict_rwx.c b/kernel/module/strict_rwx.c
index fa701dad4ed1..a3fc8d603750 100644
--- a/kernel/module/strict_rwx.c
+++ b/kernel/module/strict_rwx.c
@@ -120,6 +120,15 @@ static const char *const ro_after_init[] = {
 	 * section, which are marked as such at module load time.
 	 */
 	"__jump_table",
+
+#ifdef CONFIG_HAVE_STATIC_CALL_INLINE
+	/*
+	 * Section .static_call_sites holds data structures that need to be
+	 * sorted and processed at module load time but are never modified
+	 * afterwards.
+	 */
+	".static_call_sites",
+#endif
 };
 
 void module_mark_ro_after_init(const Elf_Ehdr *hdr, Elf_Shdr *sechdrs,
-- 
2.43.0


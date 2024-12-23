Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39DD1192B73
	for <linux-modules@vger.kernel.org>; Mon, 23 Dec 2024 09:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734946752; cv=none; b=MbY2vdn0dVKuCnEh3UxzIXydLx4WVGtuKsh/G39NQsQn9GiyLI9bIkxrYrLwsU0JVDRqT3S036n0XKMXJl7f+vz5lDhVuctgs/YcsZ6s7s7ZiaaoKzbLX95QVi74AXDmig+8S5t3qgD63pYP9d0+xmJ5uP5K3Bl6COxuDuqajF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734946752; c=relaxed/simple;
	bh=UH4xbEe0zmFXOwPUKrl24/lhmUI7cbLTQl/c73IEBaw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GhXIvictY7lXLAIKgDBX1R6tFDiU4QQNynM3PAgJ4SOuQxsgFfQ6zdR6n6U8XH+KVM/BQ7NPX/1BWyDDY09fJrdgEeOFPCiJjrxpyvmaTFJ5madHMXMISQC/ZpNpQJLPbj52/PGSXigzumzHILsJqAyjh6Zla1JCvyu4V6TjSHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=fxR+k1WO; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="fxR+k1WO"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-385e27c75f4so2912452f8f.2
        for <linux-modules@vger.kernel.org>; Mon, 23 Dec 2024 01:39:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1734946748; x=1735551548; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HLu09/IZb76vH1AepGLoCNTFGrmu/5Ir8RKortKBDcM=;
        b=fxR+k1WOP+yrLzNAlMDe3uKprLZKgG/wgPAJpEQFWc4omwMB4MGvtsscFZBbKd4K6Z
         FGpqC8dSg1Q1uzWEbcNxnx46ameWzFpk2lLG9I9S943XqtOdl3wxBVDqlva9Ilecx0hK
         m84uPkygCY3v+85a3XFdPy0Kg/UYj5Qe43Z1gHB+myP8tby2XR2dlcx2XbOm/XLtI6Cc
         qbzMGBKLHMi+WQN0Lu4BZ/I/8wo013G1mG9njLAbf2rfdSfYVbTo7XIAMXLE3RaW43Gh
         ivMYeu01k9kYROg2TQ3YJByYotYao0ISMkRrEJTeDe29dAmfe1yVmVyBoaouy11QFhjp
         gAiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734946748; x=1735551548;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HLu09/IZb76vH1AepGLoCNTFGrmu/5Ir8RKortKBDcM=;
        b=dPT2fmtyKOKrkJExyMJY71nT5QAnBiIl+5fuL+tJeXZ6gUEdEj/lrFRjsQrOxloATw
         Sxdq6G4F0ebzfOsPxy3C8uDDcmqgzqtFRLFzAwGbSC1zpkfi7GH+hoEthDc6KJTJ2nxp
         KQAz/wf9yT/QxTCA6Gyb7zUqf3J9A3iYwS5N/ZgejMF7Ilp5S64DNuN/MDNYApvMMANP
         TG3coKpTdsMWkvwjhyNvUdMpOQVA00iDwXiES67iu3UTqSD7VszEJ4PlqNdiI+XO9dcC
         VOpQxK3A7Z4K94tB3qLiVeq3+hCmB7kAmRHoyaaZQqYUCknz7aIJ5Z0b4AR7Xeqa0aCE
         Sddw==
X-Gm-Message-State: AOJu0YxI1kEYNeL000C004CTFkVejDPysuJE10CaitaYu6QXnp7tHmuR
	gu0KK4QG70iT+6l4e+sn5I07yjtNbDJd34N0kiaAkMjtEoj/HUpkySY29TgbrY6TM31uiJNHos2
	2
X-Gm-Gg: ASbGncsJzJRjpXw8zaDN7lsUW1jUYWfBH3u1DDRoFNuqKFXUHEEiQl7MzF2HqYXnRFQ
	bT6qxEFLEU55ZoZfAg9+Fbmj/o6NsH3NG0305+6g3Y6fyUPxDS5UU5XaCAcpbfWMQeorprcJVbA
	gb+N29Zb+ndM2m2LImm+u7kqTQypWqxU+Oxb2ZekR0Z0e8MhKibA5O/Zaz8jKxTtJaw4XHRlyqZ
	qtthCVIpMp5jSvAsIULsMNauUIbAnUf4ihbkKR5DItbl8D/1G5p42gPJx6z
X-Google-Smtp-Source: AGHT+IH/O/K2z2kiA821Hde63hWbwa0B+QD6rT/zP3IoMk1MAKsl29HlJV0aQSy+OLPVN88I+iGbAg==
X-Received: by 2002:a5d:5f48:0:b0:385:faaa:9d1d with SMTP id ffacd0b85a97d-38a221fae50mr11914975f8f.35.1734946748435;
        Mon, 23 Dec 2024 01:39:08 -0800 (PST)
Received: from dhcp161.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c829235sm10773868f8f.15.2024.12.23.01.39.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Dec 2024 01:39:08 -0800 (PST)
From: Petr Pavlu <petr.pavlu@suse.com>
To: Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Daniel Gomez <da.gomez@samsung.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Jason Baron <jbaron@akamai.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ard Biesheuvel <ardb@kernel.org>
Cc: linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] module: Make .static_call_sites read-only after init
Date: Mon, 23 Dec 2024 10:37:49 +0100
Message-ID: <20241223093840.29417-4-petr.pavlu@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241223093840.29417-1-petr.pavlu@suse.com>
References: <20241223093840.29417-1-petr.pavlu@suse.com>
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
index 598f89195336..4ae5facab569 100644
--- a/kernel/module/strict_rwx.c
+++ b/kernel/module/strict_rwx.c
@@ -115,6 +115,15 @@ static const char *const ro_after_init[] = {
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


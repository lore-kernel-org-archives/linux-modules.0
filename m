Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61AF11922CC
	for <linux-modules@vger.kernel.org>; Mon, 23 Dec 2024 09:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734946751; cv=none; b=QbbS94N3UW3f48SV9VfLbOISeEsssfYpWE5nB7ZcNY7vtX4aRoKrFGgwQGz2LAG5/2iydFPmUxpL54cJhYw3Exm/EZZdX/Wg+oDZAJ4mIRFXn/wbaR2ABoDClPDOPRIapmKWQqMIgx2ue9/gdrSjwi2V/9BtT1GamhsKXUF5x4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734946751; c=relaxed/simple;
	bh=u2pbYXao7gSBkL9N3hiVi/YA5ogzqx6GtUP21gPXpJo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=J+9XksuFcRxKXgORRRINmTYrp5ZfqDNCgyTAL0UZI3GZRG9j350AZNuwvWjYL04ee2erXHZCOKfQlbCsG2o2Iv50d+o2Vro7UXcAOOGUgwdUBuX3cPmnsJlAyjzwKWdg2IaIQQmKsVicS1ZN/xRnF300F3EA3ULpxnKd8gnea28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=KG6lrfRR; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="KG6lrfRR"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-38632b8ae71so2987405f8f.0
        for <linux-modules@vger.kernel.org>; Mon, 23 Dec 2024 01:39:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1734946747; x=1735551547; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dpB5AXQXFoUsjUJ3T1UA5h3wIALVsUUYh2PJwRQg/x0=;
        b=KG6lrfRR/BstlyYDgAA+e6ynTPVl2MK8+fYttl5CdG0ZKZlB0I4LmaReYKZkIYsJQR
         btwRbtoRgAUkgL2VcijAMrz1ZT6Bfj0aR4Xmk0LPU6iH9rJtcp7OLxgA5cO7tmvyM7zz
         W0ZigLzki1yYhX5rcMYASImBebB5dcayYibEzx+zUM3cxIas2D+K875zzll7kPkxX4nE
         ArsCt8TOOgxVNnIYVDNv2QamhKnZ4k3JIRRrMCOtAOSsrJepZL0YFCh6NS1bkU4zKoBs
         NlxJk/WcqYNkYZlq9OrNwcb0Sm/PcADV2cnizUJW/1zEuLEfIxR1+GDW7eKaNgY6KpW1
         ADuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734946747; x=1735551547;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dpB5AXQXFoUsjUJ3T1UA5h3wIALVsUUYh2PJwRQg/x0=;
        b=TFUROgqNIK9ZpRuYAt1RplDE9ZsdBdo80BdGBjDKaVZH6JTSsY4aquyh05XQb2ssc/
         Jbc4Ju9rSJGBc0FnExgAp3PE+AbEoYE1khuhW8ZIGZ/mLkiZLdUA6kJKVQBMtZspOQxP
         Uzs2+yLOaRoanpP5I1W6UAFpriQu/FurHd3RxELpqIPt2+wjy2fmBMbFeuDc0ycOJOzW
         Af3pu80hAFCFkNx5jHJQDXCdaBsIDd4useIGUg3iBEJ8MovgVSKpe6X+n5qAJehEcUF5
         hD9oxRSBANfFSZt4uo9hHu+t1yNPKYLZrjIlJV5Rq0VpKC8zAFjh8un085y5Gi9lmJnz
         XCng==
X-Gm-Message-State: AOJu0Yy8nTCVT6t9VdMo1z3NpfmZ49QKIGoeqs2cwndDPI9eQdhYk8I1
	8OehiowiOQX3owexi7TaEClv5hZs25vxjjMfrdL1glTSFFDi9fOe71azFvU2wFPQ/yEzoALxhgr
	o
X-Gm-Gg: ASbGncsLYNp1fpyC38rIKtX+TalSaA+Xy1F0oCyAsC+1GIomY5/u3comnxr/PzQ7NrL
	RR+y4RB0ULaAf1rcATXQDOhMehj/G0YesavDXHN45hd0P3WloeQ4uiULntkcQwB0DOMblZaeRgc
	9v1bOBcQWx3487fwZ0MoRHhudDUqS/0wigBHoJm9lLQXtSzeOZwb+06L/pQivoLjsQZQQkeD/HI
	U6UZIhHcvU8EkPZL1RuLftiOZO40be1i+KtrtHGouDh7yMzhBJixFJoJd2L
X-Google-Smtp-Source: AGHT+IFcf7gk6ft69jYRmrDzLuvuFBRs68NZ4Ocwea3I49yZ/EifY7LVldN/imD2Xv9xt2LBJpl4gA==
X-Received: by 2002:a05:6000:470c:b0:385:f5c4:b318 with SMTP id ffacd0b85a97d-38a221f9186mr8513739f8f.31.1734946746556;
        Mon, 23 Dec 2024 01:39:06 -0800 (PST)
Received: from dhcp161.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c829235sm10773868f8f.15.2024.12.23.01.39.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Dec 2024 01:39:06 -0800 (PST)
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
Subject: [PATCH 0/3] module: Make .static_call_sites read-only after init
Date: Mon, 23 Dec 2024 10:37:46 +0100
Message-ID: <20241223093840.29417-1-petr.pavlu@suse.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Section .static_call_sites holds data structures that need to be sorted and
processed only at module load time. The section is never modified afterwards.
Make it therefore read-only after module initialization to avoid any
(non-)accidental modifications.

Petr Pavlu (3):
  module: Constify parameters of module_enforce_rwx_sections()
  module: Add a separate function to mark sections as read-only after
    init
  module: Make .static_call_sites read-only after init

 kernel/module/internal.h   |  7 ++++--
 kernel/module/main.c       | 18 +++------------
 kernel/module/strict_rwx.c | 47 ++++++++++++++++++++++++++++++++++++--
 3 files changed, 53 insertions(+), 19 deletions(-)


base-commit: 4bbf9020becbfd8fc2c3da790855b7042fad455b
-- 
2.43.0


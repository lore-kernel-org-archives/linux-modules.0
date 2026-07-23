Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55FE23F1676
	for <linux-modules@vger.kernel.org>; Thu, 23 Jul 2026 08:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784795206; cv=none; b=t9FT8cf4LGeyHcFV7LcQg6hehHw58rmhARvd4GKOftJCH0DalI21dgw4mS1YIMVrAiInG4BgB0HT3OfqZuTGzfh9FEVyb82fClwSovLa6bpzgHeMBNqh+CMPA2A2ejvgHJXIuyDcTzWiQfyy+GcZGkso1pR0osFMdc8KuIGqKDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784795206; c=relaxed/simple;
	bh=x1665O34iDWpkSUEK5Br8PyhNHtKW/uRIZhK4yZtSSc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KN24Ul5fLp6nvOh+uhP6jEi0cWgWaKSjRiLd9FIqI0ae2Vw7ZIWKj7YQcNNdIQvwADZPt4O3t3BZ7+5dKxTdELM6A+YJQRKvOoGUb8VM/z6lQQ3Hf58ehD4BkkSt83uqH4PtGRtJut4LzmcpsjXRRr6qMwHgmNKN+rXDUoPH5is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=gw3BpuMn; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="gw3BpuMn"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4954a32cf1eso1644875e9.3
        for <linux-modules@vger.kernel.org>; Thu, 23 Jul 2026 01:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1784795201; x=1785400001; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=taDXBDLfJreid50wwQtpNDT0Y3B21nm5cTBQO6Vm0Rg=;
        b=gw3BpuMnTCAkaRhKpQ1pu87BvQIeQyX9f05cloCi7aLqxfkYcHRaGYEN1cErIhVWrW
         T1vLkz3gsrlp7Mkpab0AEvSlLFtqUCSIxeb4pGVepTtOPuO4DF2I89h0hpjMmizIOZVI
         j6LmzQMPQsMv1fb9pnEidsMCa6p78vvqKne5K9vJvoCu1bewF5CBF2zA7RSmC4gtucEt
         WXI4j9STdzuuiOY2Vw2K2lzklskX1IF7ykwO/KOnzFccDlvS1KiV6lJ2CVBPMpeKKeKR
         8ZkFGPRiOxTjA2VOK/uBHupLXd5kVssgPesTYuDORGG0Ug/emfkv2hXpth6//m6vgttA
         EnrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784795201; x=1785400001;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=taDXBDLfJreid50wwQtpNDT0Y3B21nm5cTBQO6Vm0Rg=;
        b=pLQZN9xGgm2VYGNIrd1sh48h8Va3v5dtSsKChMo/9A2hx2chuH2md0Q8EidDRsr1tg
         RzZ5FMkNWMpvO8HP8+0NbLVTZQApCPG3jjMCJRgMtCy24Yjq9h8RvZm+OIJSwO+5Mswo
         lWOgVvfJ2fAegU0lh74Xq82gmTboUHFzjEUjJaiN+zkubGvTv7zZMkLfqtae1x1bvfxy
         k6uz1OPIPOmsz7WYoPAaaJ0RGxc+LSb3EMGwftVeXCFmnFoyp2T5hEGSyiesQdRC9yxQ
         PddGU3Dgt4Xk8NWNF8wtb3LGjSG/vTYNOYysNR5nHI6vBurKQ0KdYIkxpSMGREsgcazO
         cYNA==
X-Forwarded-Encrypted: i=1; AHgh+RpcxJkiyh95GkKkom3jRXEqml19ctPvKe7HOfF/cbN+XfeWNatbgC1cL2EPwkiXMEWr0MU3X1VwCQg/YPH1@vger.kernel.org
X-Gm-Message-State: AOJu0YwY/E5UXEUiAUjhfFprg8QLLXuDp1l93mX7NNdWsIbj6q+m9CIZ
	nVz1tEweO5H0n7JTQ4PpwQOmtQin6F45LO6VD82+Ttr2sjatUpoahsAKgw5vltS6UFQ=
X-Gm-Gg: AR+sD10ZnrjWRdZbs1uh4MPBor1s+Ot9K1OZndekvIC0sIwn7BdMaGhPA+wELWbaXDZ
	S98/IJ7QQCC/FYryNCDiM0GrFOH5DceV+NoK8PSdXgFSutcfe9svDRXz1dxPWn4NFuulTGYwFSs
	zsCz25sX7hVVOAcyqI2KpGOQai43ihjJv2W/15/nJkZm5y69gT0WwOMnnp45Yaxf5mKPmmotC/5
	EaG2K0uZ6H/49ks/fEqq6gASei7KwKPPVrNCLoIn1WZBXWfZucNg43FFnsw8gAqlGWX/ctXzxPF
	6sHQpzv/irUfVOE3LmjtMCuO2hejUNMp0nAd4kLAAqsqd2KpsfSOpc+XNMNqM1/VKpv931oDh2r
	EONRjJXp63GeBgvGkVeptvvFrwcslroN51C0hwiVWrGOJKszS/siincfKyce86DtuYkdQ5rdR2w
	==
X-Received: by 2002:a05:600c:3b86:b0:494:6baa:ccef with SMTP id 5b1f17b1804b1-49573ccd0b5mr22026435e9.11.1784795200947;
        Thu, 23 Jul 2026 01:26:40 -0700 (PDT)
Received: from zovi.suse.cz ([2001:af0:8000:1409:193:86:92:181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4956a4f9a1csm124831645e9.5.2026.07.23.01.26.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 01:26:40 -0700 (PDT)
From: Petr Pavlu <petr.pavlu@suse.com>
To: Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>
Cc: Aaron Tomlin <atomlin@atomlin.com>,
	linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/6] module/dups: Fix a use-after-free and improve the code
Date: Thu, 23 Jul 2026 10:25:50 +0200
Message-ID: <20260723-module-stats-rcu-v2-0-bd582261fae3@suse.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Change-ID: 20260722-module-stats-rcu-ff0dfc986be6
Content-Transfer-Encoding: 8bit

Simplify how the kmod dups code informs duplicate requests about the
result, fix a potential use-after-free when waiting on a duplicate request,
and make several general improvements to the code.

Note that the use-after-free fix depends on the code simplification
implemented in the first patch.

---
Changes in v2:
- Fix handling of concurrent request_module_nowait() and request_module()
  calls.
- Avoid unnecessary kmod_dup_req allocations.
- Avoid mixing goto with scope-based cleanup.
- Link to v1: https://patch.msgid.link/20260720121621.750661-1-petr.pavlu@suse.com

---
Petr Pavlu (6):
      module/dups: Inform duplicate requests about the result directly
      module/dups: Fix use-after-free in kmod_dup_req lifetime handling
      module/dups: Avoid unnecessary kmod_dup_req allocations
      module/dups: Use scope-based cleanup helpers
      module/dups: Use strcmp() to compare module names
      module/dups: Clean up includes

 kernel/module/dups.c | 169 +++++++++++++++++++++++----------------------------
 1 file changed, 77 insertions(+), 92 deletions(-)
---
base-commit: a13c140cc289c0b7b3770bce5b3ad42ab35074aa
change-id: 20260722-module-stats-rcu-ff0dfc986be6

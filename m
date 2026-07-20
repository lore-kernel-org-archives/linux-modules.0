Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C6BD409276
	for <linux-modules@vger.kernel.org>; Mon, 20 Jul 2026 12:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784549807; cv=none; b=AJVI0SfLn5tL8WVzHMibsoNWdUcUlquHyLz40fx9Xvg16avPaR+betF4nx4Z05LAbNQrFLLAd6VyHAE0IdLcs1x2+o+eZbqB0y7d1zKeYMJynU3WLWPuhzllD3BOQN/6GysOMrdNc1kqk/SY5HN95U0tizf2Nq6IbO3mDGXza3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784549807; c=relaxed/simple;
	bh=wJbWbdN1rur3xVaX2yRXOd6/oaKcAY2L8qMu3Ja0ATU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ep89U3njgy+RSGOmKKMyYfyWfx2iJDw911Egcra+L2N42Y9UVMoM7CEcHtkMeW2Wt+og/qs2lUiVcN+bwyfh7E7tJIzPZ8fQoVE85a8aI3fdu0WHGo2a4sase4I8O4uqjmmARZxfik5N94YviA5xUfwPo96yDrVHUK+j/2rdTRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=LYZ13d0M; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="LYZ13d0M"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-495590ba856so10979015e9.2
        for <linux-modules@vger.kernel.org>; Mon, 20 Jul 2026 05:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1784549801; x=1785154601; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=BCSYAxQJs2sEsO+AD1oF3yFQHCVJ4SFjTTuM3XdQ5do=;
        b=LYZ13d0M+YY/jgUF1NGCh/Ii/dohQlgLSjVJwt004iwVVU1X/I3vE4ze8GbS8tRlPX
         mHmrBVkXRLlFFCaUz4EPqdT78oTpAMPAtVStsQ80ISNVMscBkhsPJYgUsqWMbGiJP+F2
         p0tONg6djrGVa22j9dIEUrUkXQaSGiKWjB+avVJCS2lYnX8UDSbZVSzjFGB0xIxM3dED
         KIfzi7ctrx4kLCzQDE2+1f6Md7e735nMj3iu/Ehq9vkmUN21w3p1qlBRzOx62DkK/NUa
         Ycl3eZRw41cVHOmhcu9JkJiGXmEwSDMSm0AAUz4mlfNRE0JkKlL4//mzAAMJea/sDu0a
         Bhew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784549801; x=1785154601;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BCSYAxQJs2sEsO+AD1oF3yFQHCVJ4SFjTTuM3XdQ5do=;
        b=DsILtMGgb59Ns63IoMkfg9wHBfgDYaXVU76fPAyRCnnb+8SjmHvJ7scxsM40exzu04
         dO2WVOszp8Dou+NIEaawAGi7Z1qhJDU0oSKVNnfn64c8SSf/mfxfNh9VzCAfFaWteZdu
         NfmN3j3jGyZCYm/XZ51ZZGEDpMzulu/jbG0KXCxwEIN9kfH/lDYG9v2bZg5NCmggFluG
         X5pf7Fybw2JSVi4VB9pzHPETa5uMLlKppgVl+IlksWrK0AbJXzSA4T2EPfBBbelDXeAG
         zLWQetF44+eUlzu1lchNbMeAlatsMx5CuPGULXsrjfNVHFRD9uXfJRrclkxuYUKLfIW1
         sCdA==
X-Forwarded-Encrypted: i=1; AHgh+RpFwhRyaCRU4H4AugZVOkHo+XqH7ooVmdO0PjQ+LfOZtxMJDYNEYeuXmU0CpNyAm9RN4TZjahiD6R6OYzqe@vger.kernel.org
X-Gm-Message-State: AOJu0YxPCJ5vJ/BslDIXeHwZdiEw/gGUUkhtXPlKmh2aGvH85MNjp953
	EJnoaNNfIqkoOYrlVct9iNNicjxCxT+or9p9Pj6u6Tg2UFkPxAsTzPDjlpTZaFNKMtY=
X-Gm-Gg: AfdE7cnKTf3ed85MS68/zAAB/GxMxhKfMxpSD9PrttzD7Us5w9iqoXa/KJiMaQH9sbc
	sfGWRAYzj3IS01gUa6m1awj1B2X3WBOLL8tunynW0B3agW6jDihSbNAHJ9xl7fyoD/QnLUxtqbz
	Q3zwnIlCi4oxCsdu2PkdvrdRn14HpAHGPF+mb/tfzMN3i7s5/5vNS2XYA9fLsdfQa9r3S0QDK9t
	7NGnctQMDP/OkpBb4lMTDRouAhfccK8nRGnbvqyGDzspxfBf+vljxjookx+Z2lupkxTHpPwecFG
	yj86JjUXCZLFGpSeMsvProqMehiXvq9g8CHpmQSvM60FUpw+jIZFoTu91GsGYFPLPStOVXQ1hLl
	ikie7xqWlTRW9H2ON2kIohgMkEz68GSy5XNbyuFMMzbBcELn2x542L/yCiKefjf6tvVtwc+Pp9g
	==
X-Received: by 2002:a05:600c:4ecb:b0:495:4c73:3d59 with SMTP id 5b1f17b1804b1-4954c733e07mr136367535e9.23.1784549801238;
        Mon, 20 Jul 2026 05:16:41 -0700 (PDT)
Received: from zovi.suse.cz ([2001:af0:8000:1409:193:86:92:181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f63ed1911sm31424338f8f.22.2026.07.20.05.16.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 05:16:41 -0700 (PDT)
From: Petr Pavlu <petr.pavlu@suse.com>
To: Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>
Cc: Aaron Tomlin <atomlin@atomlin.com>,
	linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/5] module/dups: Fix a use-after-free and improve the code
Date: Mon, 20 Jul 2026 14:15:25 +0200
Message-ID: <20260720121621.750661-1-petr.pavlu@suse.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix a use-after-free in the kmod dups code, simplify how duplicate requests are
informed about the result, and make several general improvements to the code.

Petr Pavlu (5):
  module/dups: Fix use-after-free in kmod_dup_req lifetime handling
  module/dups: Inform duplicate requests about the result directly
  module/dups: Use scoped guards for kmod_dup_mutex
  module/dups: Use strcmp() to compare module names
  module/dups: Clean up includes

 kernel/module/dups.c | 143 +++++++++++++++++++------------------------
 1 file changed, 62 insertions(+), 81 deletions(-)


base-commit: a13c140cc289c0b7b3770bce5b3ad42ab35074aa
-- 
2.54.0


Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFE793B1BC
	for <linux-modules@vger.kernel.org>; Fri, 12 Jul 2024 20:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720815623; cv=none; b=ojjBUZQogojE8UFgS6ne+unzdXIpZgoo8G6QIfbJN9l1tRWEfAjuy0wqlMQX0akm4gI2uKq3D1g4SAojeVRzT/T1uuaVIvqa/lBdtVyiHi3A4VbIwUKiC1G2C+SUfDtg2eoTTewvvLz+OVpLhL93R/8INs2UsIXXEmamUy6YOkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720815623; c=relaxed/simple;
	bh=bs28XFB/pvWEPiOIYn+ZPuJ0O4E3/IVuMY+c5SgzGn0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=p4ZURn8JgAdtZss1R53JttdR6LdNu3za8nSxrRmNP4oeqye6VaO35eYb6j9EzFFhalsNZkp50YNkwPt4U7W/cywn4UR+MFkU3BaAmZSqvjEhCXyRF1Rv45iFyifsHyzjvBqRkgf4EQpDzjIIhGlyHBq428VEOoscFaJwAS8slPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MhmeJPHo; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MhmeJPHo"
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3d9da46ca13so1207394b6e.2
        for <linux-modules@vger.kernel.org>; Fri, 12 Jul 2024 13:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720815620; x=1721420420; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=413RuQ7gL1ZnDD9GKlt9WjHqGUCpYSVyI6AQx2FB/r4=;
        b=MhmeJPHopb2KHp/7U8e8bc7OopTCRv2eAJM5fHCQPqMYnHeEyZNNey09/rvc3M1U3l
         uwXKeSLVfxoznMqITMs7cYC1k7ZjBvoB96IAF1TEaUc3g2bcfjI7T7/Q0xSW+eWF7CLN
         TGQQEgRj10IcIJNIQas8bbAZrnexeoZ0h0jjnX/RXVCLNjgmmZZqfg3i2u2eL8fvCjyi
         zT3V36yNyKXejmr4PT1LoXAnxVTh3eviu91Q+Fgr14ClnT3QgMpIp4gwPauREw01sIsJ
         xDZ/ThSyIhsYIH22fzhb9GdX73w+N55Dq7oSVtEaJv7HNwyKA5qKtrM7JU3suyQso6oR
         FlYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720815620; x=1721420420;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=413RuQ7gL1ZnDD9GKlt9WjHqGUCpYSVyI6AQx2FB/r4=;
        b=t/pf8us6fGOpHEp1SFzXdEbqW56NWIVU6I691pYVM+2zXo3nK0cLG6vbCMpzM3mOOf
         j/auAlPNFZfSpUMz5wOkmLqmHla34+HRMZraxyXLlp8KYUpSJdNQypXx69zAgjS1z9er
         +tGhuRlCW03itOnc+MBhfwztyWoMJV4+yZDVR3kv2aDoR3rGDBn17Dagmg8GSnnVQR1b
         w+anudaXRRqrKwmRbU7N24muESi0Ap3SMnT1rEyNCiOtLlipk4/RlrpBQsN8No2KJES5
         ijUvAaW2KdLGTiWaFwpgFtI/oBnDMgli6nsn155uR7oaCj3tW3CgNeYZz3PJo1Z7o8Sx
         0FUg==
X-Gm-Message-State: AOJu0YzTynLuCQufiJrAEro1ELuNlWcEHPDHQj+Dia0rF7OsATFJny+T
	+hlDSxmYYsxQNj8wonkpt4qa+kgjF3KKQhrXpdx3lVAZDFbRjJid4Z+s1g==
X-Google-Smtp-Source: AGHT+IHJ7jNx5InBJCHYFF8TpjbSePp1XFLTj1pk90aC1DKPWwXq0lFLtAeql5LT1F2v5PItCfugWQ==
X-Received: by 2002:a05:6808:15a9:b0:3d9:2aa5:4077 with SMTP id 5614622812f47-3d93c038484mr15642908b6e.5.1720815620054;
        Fri, 12 Jul 2024 13:20:20 -0700 (PDT)
Received: from ldmartin-desk2.intel.com ([2600:1702:4eb6:3000::3f])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79f19028f7csm434473585a.67.2024.07.12.13.20.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jul 2024 13:20:19 -0700 (PDT)
From: Lucas De Marchi <lucas.de.marchi@gmail.com>
To: linux-modules@vger.kernel.org
Cc: Lucas De Marchi <lucas.de.marchi@gmail.com>
Subject: [PATCH 0/5] Add distros to github CI
Date: Fri, 12 Jul 2024 15:20:06 -0500
Message-ID: <20240712202011.906033-1-lucas.de.marchi@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a few distros to CI to improve coverage. This is now executed
on Ubuntu 24.04, Ubuntu 22.04, Fedora (latest), Archlinux
and Alpine (latest).

For Alpine, the testsuite is disabled as it's currently not working. It
can be enabled once fixed.

Results:
https://github.com/kmod-project/kmod/actions/runs/9913631414

Also available as a Github PR:
https://github.com/kmod-project/kmod/pull/44

Lucas De Marchi (5):
  ci: Replace package installation with local action
  ci: Use a container and expand versions
  ci: Add Archlinux
  ci: Add Fedora
  ci: Add Alpine

 .github/actions/setup-alpine/action.yml    | 22 ++++++++++
 .github/actions/setup-archlinux/action.yml | 16 ++++++++
 .github/actions/setup-fedora/action.yml    | 27 +++++++++++++
 .github/actions/setup-ubuntu/action.yml    | 23 +++++++++++
 .github/workflows/main.yml                 | 47 +++++++++++++---------
 5 files changed, 117 insertions(+), 18 deletions(-)
 create mode 100644 .github/actions/setup-alpine/action.yml
 create mode 100644 .github/actions/setup-archlinux/action.yml
 create mode 100644 .github/actions/setup-fedora/action.yml
 create mode 100644 .github/actions/setup-ubuntu/action.yml

-- 
2.45.2


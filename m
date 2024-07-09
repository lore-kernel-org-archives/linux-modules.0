Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C685186E3D
	for <linux-modules@vger.kernel.org>; Tue,  9 Jul 2024 13:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720533021; cv=none; b=N0GAfK5+IatRN2Sa7CVG8hgXI1kXHJ4Fs4tdOjXXnKEOwYsBSBgdu7rUH/JeO7vIoh47PoHKUXB0prKo39Yr6EWoBDC9khjVLE70UjBNK0qB00n9G6UYPbnJTsmGnq1/GEI39BhfNhv5lBaKiW1WTft5g9HIxsLqVacczu3kLLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720533021; c=relaxed/simple;
	bh=Uog3PHNBcVee8GOdwilvzIHX+9tusLvpWzDNw9T2Cis=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KxcMq+oSvdZNNQ2ZL+3hRq2Vt1I2wx7wYrSTN3T9GKQTIcln66+RRs3UPXiPwWDEKQ2wp8LoM0CacZu94uZnrAzSc8OA3A1iU80kMLEaSi12QEZ2TANSjTwKd9aOBGJhOLd+lqol5B8jJEupRalOaXwq5OIU5830nPDc5RNjpdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iAsUttlp; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iAsUttlp"
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e03d49ff259so3731588276.2
        for <linux-modules@vger.kernel.org>; Tue, 09 Jul 2024 06:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720533018; x=1721137818; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Sl0Ulua6E8PHCf6no8ij3NZTjdvx9dSMsMXIH6PvV+g=;
        b=iAsUttlpD4NDwQ36Ai6aldXbZyjRI3UB7dNfeqafxDsQhLD0CQSumoAKpqmfhoYVB6
         27xmhvwpq/qjuFf/pBK0avXllFF3drpm2wDZoTZLe3SedPGB1u3LL2+NdET2q5q+Ntjj
         nRK9Argd78vA80Fjd2rh6vpys8dStRHv55L0DjnI8xnHRsjUj5+SCLTwN62e7bzWo2oD
         Dl1vq1h7MIiuHAowdQjFsBQjKX7vcKequZT8xERD15mHxt3aWB0mcDQxgrKf1z4YOTD7
         /p+xNNgV5bUVTtz2tWTT+5V6PtLkX21yJmUtTI5HIbOhRt3JxralAv/rcpZgw6gWf8FV
         fOzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720533018; x=1721137818;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Sl0Ulua6E8PHCf6no8ij3NZTjdvx9dSMsMXIH6PvV+g=;
        b=jFYmoAytw0JiKbb5bWahcPZev091z8CBxcFNVtpjDrEZeUEgw6ZkYUVE42J2o+/mJe
         6jjwiPNJgQm66C4sgTUHjdpIaQea7Suo+zTUliyNkRA35LlTG2xcIiLwCkA7h0KX2pVM
         3uh0NUarrTvPwQwdEb9dFcIU3SVRqQrSM+TnAf/+fOO1n72siQ3oSPFscWi4QJk9ylqF
         ujBjDqnEOYivpvg79N0s1FW8n8KTjziv2O4adOUo2j9Sr5yO7vtF/+hDzXxKSYSmfttn
         0zyc5U4xxJzDmL31WNQvh5RCzzD1fxadMCe9kw8hdRZt0khRvy+vt0F08FmEu21j9TyO
         REXA==
X-Gm-Message-State: AOJu0Yw6S2sGJjkP5OC8hSFmYpzUZ6J9ZEQ0Kq5f4rDE+2gYthoimjAQ
	3rKGHkqXuKB2Wflb1eKy7zrjP4SlRBs60TdCXhZXYIVEGQInSfW/2WVFZg==
X-Google-Smtp-Source: AGHT+IENdrYXRfoxbF1G1g01OsVjN6tJxfb2TH3qIkdsGtuUUE44OgW524afhR21lsjuR7MqLk1epw==
X-Received: by 2002:a81:9256:0:b0:644:b209:4de1 with SMTP id 00721157ae682-658ee790eb5mr25883067b3.2.1720533017681;
        Tue, 09 Jul 2024 06:50:17 -0700 (PDT)
Received: from ldmartin-desk2.intel.com ([2600:1702:4eb6:3000::3f])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-447f9b4e536sm10604831cf.39.2024.07.09.06.50.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 06:50:16 -0700 (PDT)
From: Lucas De Marchi <lucas.de.marchi@gmail.com>
To: linux-modules@vger.kernel.org
Cc: Lucas De Marchi <lucas.de.marchi@gmail.com>
Subject: [PATCH v2 0/1] Use github-action for CI
Date: Tue,  9 Jul 2024 08:50:06 -0500
Message-ID: <20240709135007.104325-1-lucas.de.marchi@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Besides being in kernel.org, kmod is also hosted in Github
at https://github.com/kmod-project/kmod/. Let's use the quick
integration with github-actions to test we don't keep breaking
build/checks.

v2:
  - Fix to distcheck has been applied already
  - Squash distcheck addition since now it doesn't need to be in a
    separate patch
  - Also run on pushes to master branch and on PRs

Lucas De Marchi (1):
  ci: Add github workflow

 .github/workflows/main.yml | 56 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)
 create mode 100644 .github/workflows/main.yml

-- 
2.45.2


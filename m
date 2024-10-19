Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ED5C17E46E
	for <linux-modules@vger.kernel.org>; Sat, 19 Oct 2024 22:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729376875; cv=none; b=XntYipRmV7QJti7JPv+hrs8LNCThjlDdP0Q1603D7tS9d0VhdWaHsilGzkY36haItJ5wzcwcYbXXQBs2GD/1qdLPWgY99Dg8ETw6zhTtSauZJ3miZMKbqswJSxFVtpxyRWW6ILvg1RZ9G7TyASVHtM50yOSVXaAmLfeZD5Yk/Xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729376875; c=relaxed/simple;
	bh=GZhTFENFwvp6Q4/Lu4wYCmkLCY4N6YThPVFoJCA4jrM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qMCuw9+AYxDlN68LbnCuEFCKlMNWme9xrwrDQ9YO4G/Pliz3mqEX2YInruPG1rHhKATqif+qXdFZzKorm/cEhWFpRtWCJj3RLTySB5pHBfXZFTQENYhKSR3Q2npoqOeussaBPjCPm30wAJCTpW+uEToaf3vjeIK52GFprOKiBlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eRfK0Lmn; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eRfK0Lmn"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-539f2b95775so3973840e87.1
        for <linux-modules@vger.kernel.org>; Sat, 19 Oct 2024 15:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729376871; x=1729981671; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:reply-to:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GZhTFENFwvp6Q4/Lu4wYCmkLCY4N6YThPVFoJCA4jrM=;
        b=eRfK0LmnvPxKXxWxmfkOXJrDXwHJKH6Q6InxZ914/mKhTgmCWpU11M2oyK0sCzj9eq
         LhN3FJSRO4nNw6naoO4p1wNxtbX7BzFLg6weIBnZI9Xxu/gh+QApNO1T8rYSD9swkFvN
         bs3ls7zjneFXCQn9WgQWYCXIPN534UtZDlu4kCO21LHJrru4VOoCrsA/Ed/HJ5/8DEMR
         YMfpY1+zC394c15u5Rvn3kOSajskG6E6Q3Bn4Sujb3OivqfRBx2O1QEVN2g+Yszsnz+E
         aPqQQMb6qPcP6+ve7yWJ0c83s5jeaJGEsYBon6/d45181fp3F17sLokk7DNIVNoAIU0d
         C88Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729376871; x=1729981671;
        h=cc:to:subject:message-id:date:from:reply-to:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GZhTFENFwvp6Q4/Lu4wYCmkLCY4N6YThPVFoJCA4jrM=;
        b=sFQtqzS0Y4cmoWensbvzKo8TPAq1bm/rHE6bue6kN6UAp27U3p+FSTzZNoipnFC4Yw
         CSCkThiZaVxhDGe5maYeyidHYS70E4T26H794x0fVx+zM8CDxqsdjA6twTeUg+kmurr6
         Q+o5QQZXhAfbwGJzgxU5xBQhTcUBcVbu8KkdrBpol/INFfFxUA0abAuUTM3LawjB8Fsp
         qj9MRozJympr0MZo2lNMhgUHl6XxqhXEpDZcxSv9N+uBeqgd5zwRsZxvxrjr1UB1rclW
         cKOX1GKbZt4LjwPrL+7EY3OM/g2loW2cv/WUBU4mbGT/7n2UZ8Mw0kJSg9ehROfkdK1X
         7Qmg==
X-Forwarded-Encrypted: i=1; AJvYcCXCqx8bxkzvY/EZ97sdtFcht+vg/nhtKZcUzLncUymPlqRmcKE/n3NqcFEzV/rRrYBV5eNNuUMJZa0yjG0I@vger.kernel.org
X-Gm-Message-State: AOJu0YzJvG7wp+iaYkaI9EU4XBfz1uYSUzVgII0QlksEU4S/22CUsbtE
	O+0f9SF/EIeZZJQv71i6ocSz+ashSFE4QHJKmrrq8CSPA+hVs/GNjo9QOVJ1zKkrk5i2RAYLmA4
	BZUoBmyEUbb7ruVlrRW7wcXs7Pb+BnE3Uzc0=
X-Google-Smtp-Source: AGHT+IH8UK7jtIPah3jVaAFEUhEAM1jHv8ikN1nnVEs23b7wSRJw0lM3VMKrB0M3SDo5+/7cUtIeOQrLwmrAlr6ZCuI=
X-Received: by 2002:a05:6512:1294:b0:536:53e3:feae with SMTP id
 2adb3069b0e04-53a15340876mr6449754e87.11.1729376871278; Sat, 19 Oct 2024
 15:27:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+icZUULLhDyScuQnM4Tx+JD9xMFhnKVkxepUK_o1jGhJGo+bQ@mail.gmail.com>
 <CA+icZUW_K-f-ATDuvtsjXokx7aWUcfh7XpW2JhxBeegXp3V4xw@mail.gmail.com>
 <CACvgo50-oorSp+70CctrxQRt04T5bkrO-z4uX66GeBFXROxYZA@mail.gmail.com>
 <CA+icZUVi8_17bPgGYFph-Jc3bhTRRVZa1K8dJgOChHors_ySFA@mail.gmail.com>
 <CACvgo50dFQHROV+JhJOgutDOTYQg4R9aWTJdBXXhNWjR_rF9Bw@mail.gmail.com>
 <CA+icZUXt5iDqw43-vxCamYFpz0SpaiWNfgkj8e+a5LwK9E5n+A@mail.gmail.com> <CA+icZUXuWwEz+h_bRGK3sP_hLnzjYh+8McUGQJzqcqyr58K+_w@mail.gmail.com>
In-Reply-To: <CA+icZUXuWwEz+h_bRGK3sP_hLnzjYh+8McUGQJzqcqyr58K+_w@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
From: Sedat Dilek <sedat.dilek@gmail.com>
Date: Sun, 20 Oct 2024 00:27:14 +0200
Message-ID: <CA+icZUUJqsdf2uibrBoCWaMHTtefQ+7ZFMFsCvDbN+KrA+QtTA@mail.gmail.com>
Subject: Re: First experiments with kmod-git and meson build-system
To: Emil Velikov <emil.l.velikov@gmail.com>
Cc: "Marco d'Itri" <md@linux.it>, Lucas De Marchi <lucas.de.marchi@gmail.com>, 
	linux-modules@vger.kernel.org, Tobias Stoeckmann <tobias@stoeckmann.org>
Content-Type: text/plain; charset="UTF-8"

Add strip option to custom INI file:

[ build-dileks.ini ]

; SPDX-FileCopyrightText: 2024 Emil Velikov <emil.l.velikov@gmail.com>
; SPDX-FileCopyrightText: 2024 Lucas De Marchi <lucas.de.marchi@gmail.com>
;
; SPDX-License-Identifier: LGPL-2.1-or-later

[project options]
build-tests = false
debug-messages = false
docs = false
zstd = 'enabled'
xz = 'enabled'
zlib = 'enabled'
openssl = 'enabled'
werror = true
strip = true

[built-in options]
buildtype = 'release'
- EOF -

BR,
-sed@-

Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D6B3398915
	for <linux-modules@vger.kernel.org>; Mon, 18 May 2026 21:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779141351; cv=none; b=A3GQ5fW2Ke1LnV1jNgEQnEGOgfMWEUR66K8YbdjvaQBcOhNtidZSx0JHds52Q4RlxfWCd0ScugOGfXLdwJVXwcDQ08e8ZzHImeyYX9z0/P0Xl5Mg9hQpi51NUyO/sSZXZyopL/EmRaCiDfYePmQHBnDrxh0TG7gIJhtAmEjo3Uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779141351; c=relaxed/simple;
	bh=WhaVFwVRm1Wf4thmzuA0e0qjOQLT9x+04R1dduxYWzY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QLiUFZ1gS7gDEc5iWppHGVY/UBO1j4ru508PC8hhKehmKwb0YRYvYgTK66VPHiD3TrsL2j3Y0v9BTeC6Sy6Pa9mjziMGzANXsWKB4BmktdGoolRxdu2QvgagjIlChMQ4xV7zxbBhABcv+MScq7x+QvL6JmfacgOL8E3r7YZtx1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IvoDbo4V; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IvoDbo4V"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2ba3b9bcf69so765ad.0
        for <linux-modules@vger.kernel.org>; Mon, 18 May 2026 14:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779141350; x=1779746150; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=eATlafWR2CpUln9HSfV3CyzBd2Vyaqeh6UVZyYqlodE=;
        b=IvoDbo4V1nj4Q9OWvBMcUPpA6eDFfBAFbu4ry1ujeKWH4fYBAFNjP7BApepEoXKgFW
         echIH2GbEhb+kGhHlHfftLXlBnHDih1oHm9UtaSSK5CAFRUvXh1PCqOj+XI9wKqJnmv9
         BdHZsxEJDc6k4l629t6bytiQfWInZt6CAKX455PJMRgqGvsL+3fHb7ubaoj1OjP5TMpJ
         apWTAqJbeutKX9DtvRx+hRvKlId5JUFry4JYzoUpiHudyEvfAoPlfnA1GOb/KpKOehgq
         VY2sjO/zadidGT8zNRrbzepfosggp1gNZrno+6RpVU2wOW8V9Y0N7qAHPHbOdQPTZ4W2
         afYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779141350; x=1779746150;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eATlafWR2CpUln9HSfV3CyzBd2Vyaqeh6UVZyYqlodE=;
        b=TSK+4ywValGhp2ak6l0eR7KFlmvcHoglOgxD4bb/sNAfP6FrZRkh9AeD4ud6HCWT94
         AoPM5erb3LrQySyo/ZkHCvrkL9SPj+6oTePM7MpQN/SKg/3ZS9Ait2n3GIgV8KuvzV/P
         NwYt+G6K+vYTfC7Hq+7kFjfuJF05U/ha6x8+HwNYSX/ikZMtx5bEiWqqL7IczmRnD3YA
         x1/DZVIpkHrzMd16xPmMmLeXmqnLQvcmvECv+uz3OjjoRyPYDRz57dFbCkKtnIqSHkjH
         vD9fezqZ6tYJQTKWuCGI8kmDmSzDWzin3lu7pz5Xn/F5+maeUuhhhZMgJWLp5605txJf
         DSkQ==
X-Forwarded-Encrypted: i=1; AFNElJ9lK4IkjQKs+U7yQ8M0VVGN0/o7xgf2qX3pnjB5Gfan9EZiykevYhJMbAGxGWeHL/JJ9UIbpZ0kYZZJK6kj@vger.kernel.org
X-Gm-Message-State: AOJu0YxKPtQSU6z++bdlOErV0K6tOEHUO6WfuZrf1zcCOVlRu9yPg7k+
	SzX9an/RSM6S5owk/9hHntzN9fehCLqI66L609cHr6arf0x+FPPrf06AwcTUtois6w==
X-Gm-Gg: Acq92OGsC1KL6ufGQEk67BE+nYrCQ6MmlhOSOqAyZknttVtcraM3t62aoSmMVpOZiCF
	/UbsVq6AoxFCKwAApkSeu1ePCXobwsiaKuc6D1lgkNG0t2BLhskVQoBfLksM9B3vERykFkQyIJY
	e/bYnFARWzOcYxIIkQhjIa9kbfcUXz6NrqsRoUt6U8JeCWyq2CUr4tfUfmvNfFcuk3NTnJbrmfr
	pzumei58NN+cMStkL4aF9PpZQ8/k2QdIEameNRsCrkHyaTSmgZfozP6yLCeyNfXDgQA3wN7UNcP
	4jtOCv3yIPjCG75p+LQFXDVFJuX1WKY8kM0rER/QOeSlvTAw4CdObYEpYn1eW4N1ldWsYyPdocm
	qY/DQ/AfZosXZvfsvgcM1SQCvwjBiyCMnr96F/C9cs/7DdYJexn2SHAekINibBVG+kc1E9Pgh1T
	0GYtXXL0otC5zpmQreR7ok3vHIhDMhFGYamh7r9pnfMVzcMuMDVsF5rE4kInFOhVzcam4Wywwrr
	u94XFzUClA+mvDJ
X-Received: by 2002:a17:902:d512:b0:2bc:dc0b:ab29 with SMTP id d9443c01a7336-2bdb0109472mr3880435ad.0.1779141349445;
        Mon, 18 May 2026 14:55:49 -0700 (PDT)
Received: from google.com (171.46.125.34.bc.googleusercontent.com. [34.125.46.171])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5cfe498asm164380125ad.39.2026.05.18.14.55.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 14:55:48 -0700 (PDT)
Date: Mon, 18 May 2026 21:55:43 +0000
From: Sami Tolvanen <samitolvanen@google.com>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nsc@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@samsung.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Naveen N Rao <naveen@kernel.org>, Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	Eric Snowberg <eric.snowberg@oracle.com>,
	Nicolas Schier <nicolas.schier@linux.dev>,
	Daniel Gomez <da.gomez@kernel.org>,
	Aaron Tomlin <atomlin@atomlin.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>,
	Xiu Jianfeng <xiujianfeng@huawei.com>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>, bpf@vger.kernel.org,
	Fabian =?iso-8859-1?Q?Gr=FCnbichler?= <f.gruenbichler@proxmox.com>,
	Arnout Engelen <arnout@bzzt.net>,
	Mattia Rizzolo <mattia@mapreri.org>, kpcyrd <kpcyrd@archlinux.org>,
	Christian Heusel <christian@heusel.eu>,
	=?iso-8859-1?Q?C=E2ju?= Mihai-Drosi <mcaju95@gmail.com>,
	Eric Biggers <ebiggers@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-modules@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-doc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-integrity@vger.kernel.org,
	debian-kernel@lists.debian.org
Subject: Re: [PATCH v5 00/14] module: Introduce hash-based integrity checking
Message-ID: <20260518215543.GA1878854@google.com>
References: <20260505-module-hashes-v5-0-e174a5a49fce@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260505-module-hashes-v5-0-e174a5a49fce@weissschuh.net>

Hi Thomas,

On Tue, May 05, 2026 at 11:05:04AM +0200, Thomas Weißschuh wrote:
> The current signature-based module integrity checking has some drawbacks
> in combination with reproducible builds. Either the module signing key
> is generated at build time, which makes the build unreproducible, or a
> static signing key is used, which precludes rebuilds by third parties
> and makes the whole build and packaging process much more complicated.
> 
> The goal is to reach bit-for-bit reproducibility. Excluding certain
> parts of the build output from the reproducibility analysis would be
> error-prone and force each downstream consumer to introduce new tooling.
> 
> Introduce a new mechanism to ensure only well-known modules are loaded
> by embedding a merkle tree root of all modules built as part of the full
> kernel build into vmlinux.

I noticed Sashiko had a few concerns about the build changes. Would you
mind taking a look to see if they're valid?

https://sashiko.dev/#/patchset/20260505-module-hashes-v5-0-e174a5a49fce%40weissschuh.net

Sami

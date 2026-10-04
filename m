Received: from mail-oa2-f34.google.com (mail-oa2-f34.google.com [74.125.231.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 415EC368277
	for <linux-modules@vger.kernel.org>; Sun,  4 Oct 2026 17:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791133586; cv=none; b=BFtfRYRh0X/f4AppbohCaSFD/bQK4Xk8dWsBr45mCVIkw5RX80ZzL9HNvsoXj2hLpboKO8BEoLu0Waadx7Tgcf0uUPG86WpyVrHwPFHbKUAVOLoJx/YKLP2kbfvlN7kWutvZI3LSk6ErNKSBOiOpdIX44hmrg8gPeEXMHQO/2/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791133586; c=relaxed/simple;
	bh=vEr4v5UzCxd7Q67cxL7C+j9r5X+UpcvxAXoDSa/XGrU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OtpsMe9r4Jb9lGDoUW0DE930DRdU2AemBBUT6swscml3+Gh0SERoHyAGh3aRQaFnrcCo0It1tLoXleMOdF2E4Ci/A39hF6GoYFHzq8NuD1mW0BUA0IVPypkQBiIq8IN/B0cliWGxKmyXF+NgoS2HjQZj52sDja4nIeWDOOXp4No=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RqlYikaO; arc=none smtp.client-ip=74.125.231.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RqlYikaO"
Received: by mail-oa2-f34.google.com with SMTP id 586e51a60fabf-49aa2fa57adso125688fac.0
        for <linux-modules@vger.kernel.org>; Sun, 04 Oct 2026 10:06:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791133584; x=1791738384; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vEr4v5UzCxd7Q67cxL7C+j9r5X+UpcvxAXoDSa/XGrU=;
        b=RqlYikaOnxkDd6DbFJrHXtch1lcBXpVJyZqO2aJ7xM2QOZKTmcygg2u40hZOZgfs1N
         Mbm4jgiuGdCfyBS0VDO47O0OdRYuxAorVMYwiaWGtLlHz7oyFoEvwXZ2SbQkrueHhCT1
         mTESKW+zVXxLk23BeLti6t0Ais8X6jGTdGD5HoGrnEQEHmBIBayZYgddExZopd0bJ/zD
         +hNqzxMW5p2aISIEsoR/fTHbyUpjVroqYb4ZBZZutAlqr4YRzH0fhWrV7S5mzMSMZWje
         DK3Bida6sorx1VAD5nQKGeqdzIar0Rakk9/I3C83446nIysUoNy1dGzGlFGJx8H0MMod
         seLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791133584; x=1791738384;
        h=content-transfer-encoding:mime-version:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vEr4v5UzCxd7Q67cxL7C+j9r5X+UpcvxAXoDSa/XGrU=;
        b=zPBt9ctApTwj8bC9q8ONNhI5dCI85ELCT0/7q+v1MeUIv670NveSsPWEtDnCR7jJfQ
         Z36TveKW3+xmvup+79WWuZkTdSTX8IGfUHUBaSiVnjeZdtSNG6RR8y8QlySg/wcrCzQp
         YMp8QIGjRBTSHfXmzg1jBFSfw3qWWv+otu5sG2jQ+792enl1pgqcDIYYwA/FP2iaCbUR
         0xOvw1pkQEflRCTMXcLGxBhT2HVk2Yzx2XrlsIA4rIgAsU3NTze0xx8FGkF6W3O1eWz6
         KVwjZp9h9cjme7DX4MlQ69JOCOl6H8qxQWGgm0Qz15LwOtVDQljRnqATStKv/4+q+AZO
         sVMw==
X-Forwarded-Encrypted: i=1; AKwUvBye2qFnI70Pa1vbfag15zl1u0PfHGtO6rmTOOoVZrtIthi3I1OCzVbagkxMBCvhE3GM9h5O9GyWiRV+ZB7y@vger.kernel.org
X-Gm-Message-State: AFq9FYIjkDGbA3uVyRNI1XJMwwaw29Py6+JRAo1wAWd7jfmMrGWyYbXu
	RUNR8wiGFeNNOtZGm3Paoa2/Rf2SLGU0Jggcx/IevZ/wOYx5rpfnvWGc
X-Gm-Gg: AYBFou3giVtoAoPsluWm5DlM01kMVl0Ra+VohtA4VoPdNLqjfQM9nnOcZZVq5+U+xsO
	yF0ADVXW0flhhnhIyoxjaMFR0s61Hohp/Fo7XnxmcVL4gBDONElfpa8drjvAsO1MinJNjWlCH7f
	f/7bWRNT98ouDdrUThBp+xdxARAwiewaUzu3Qt0KTHrpWOXXicqRX2xFgd21tAnDHL4A+qBP8WG
	tb4qONuzwwJPjZZNoQ6JAGpb4790yCMDkLEp/4OrZ5sYW3bs5uQB5Ar+RsKQLDBKs/nDL576Lyc
	sImcYiui8OXWUicfLQCj45+bqcsdDV8ZjBBk90TWASUy/6V1MGzsoUF8vTTxnr3jIjBTV7pfAZ4
	C/0VkfAlcxGwsmMK9amv7hB4qDNESGrrZLf+Zm2rZizc9xMeRX2jMNDfgEwAv9Zvj+aiR5XRJoh
	FyQKxHZz1ipl2M3B+YP/l+gNPWYndo4Zbc9CpQCnY6LPXxKwbc71H8OW7awd8KSiEtrduaoLjUh
	FSeGd/x8cabvWAON1Sr2f7fIqe0kpcjN0H1KVW5tfKRGeX1fZDjQ86lZOOOWozdVrbvoMfjBWUL
	tHfvl9BHJg==
X-Received: by 2002:a05:6870:c115:b0:497:2e21:f7e5 with SMTP id 586e51a60fabf-49e15e91b0fmr5947738fac.25.1791133584217;
        Sun, 04 Oct 2026 10:06:24 -0700 (PDT)
Received: from starship.unifi.local (107-216-42-6.lightspeed.austtx.sbcglobal.net. [107.216.42.6])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-49e16545353sm7403626fac.0.2026.10.04.10.06.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2026 10:06:22 -0700 (PDT)
From: Lawrence Lin <deduce@gmail.com>
To: David Laight <david.laight.linux@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Petr Pavlu <petr.pavlu@suse.com>,
	linux-modules@vger.kernel.org,
	Stanislaw Gruszka <stf_xl@wp.pl>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] ftrace: Avoid quadratic symbol lookups in ftrace_module_enable()
Date: Sun,  4 Oct 2026 12:05:59 -0500
Message-ID: <20261004170600.1541723-2-deduce@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261004100030.189b1c3d@pumpkin>
References: <20261003-ftrace-mod-bsearch-v1-1-92e2fd2d80ff@gmail.com> <20261004100030.189b1c3d@pumpkin>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, 4 Oct 2026 10:00:30 +0100, David Laight wrote:
> Surely it would be better to add the sorted index as part of module load
> so that all symbol lookups could make use of it?

A sorted index used by every lookup is roughly what [1] tried, and its
review showed what that involves: aliases, livepatch's references into
the symbol table, and the lookups by name. I'd rather leave that to the
module maintainers.

For this problem, Steve's reply suggests something smaller. The weak
locations can be dropped once at module load, so ftrace no longer looks
up symbols per record, and no index is needed. I'm prototyping that now.

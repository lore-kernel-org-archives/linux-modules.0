Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F338925A655
	for <linux-modules@vger.kernel.org>; Sat,  4 Apr 2026 00:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775263035; cv=none; b=CZgx3rDy6qpN/hhqFoAsV9ZkC1YEVXqhBGMUeG+4iM6HmaF/yNu5vofDHM5JE/azAXevRhFH/4VSWyUOCNBeZpZqzFgo6bIQm7jY9D5vNIpPltNy32xCkxnwqYdwxtTaVaXRgYJtNpXEUcU364J3aFIVufIMLQYkgge65cnaZ6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775263035; c=relaxed/simple;
	bh=VRW7wRW2Q9r1frAdP8PWIidOriIPo2srmhCCTDv7jTw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=EYtHGz0u1XOmLQ1msRyECiagdI/K8x3il+36Wl5kr30NKdSNx8HlPIZ8cCRrwv3T98EkE26+UWU4Pk9cWVtV/517MNrKBPrhnCD2wm6PrmPLZEfdiBdkOkja/zusEBA0jOls0KF3lKpg1/X8dDUVH00+Eft8Lvj3nAR0W/zqM0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ij4yOdY/; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ij4yOdY/"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2ba8013a9e3so2920644eec.0
        for <linux-modules@vger.kernel.org>; Fri, 03 Apr 2026 17:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775263033; x=1775867833; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3x1eiPd8cw5y47bgewxMpWPbrV3i1xPOtcWTmsjzHhk=;
        b=ij4yOdY/AYLqfIvHo0B21GI7Fban2p5xjP9dfLmkVAip7vHPGpgfXMwZ7Bujhp/SFe
         +H3U9qmx49F7X6708y91nHEi1+zu5ycbDZiEpTUl8SG+pJUa3tI8R6Kx5MGg1OTqzJre
         macOsafIhIQxeUjM15Nq13U0PXtiNWurwjkrwNplXcrrR6XPnj5LXMQskD460VCXYuQp
         QO8KI2Iee4XrEVVdRMD4oqlu5s2pRSXtvlJs++85vtkcIHu6F+SKqO0c4ysdf1mZ6088
         kcaqWlkcGLGe/hQqjGcx2w5V8m3FN8BpLZLCpzFZdpogHKWrLdaoziliQLtGTtTaVwj6
         p05g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775263033; x=1775867833;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3x1eiPd8cw5y47bgewxMpWPbrV3i1xPOtcWTmsjzHhk=;
        b=jE5wjTDtnz+MerrA4a+4HeKRblgo6UphUPu1PRQjJWNkTUj3UB52WS15ZGjWhxaqne
         LC9/37XeOie7dEU1IyN5Nbdw9+d7UkuynO3L6IkmL5TUHiG+vI7jBxXXs1opB2unDTAs
         Abh9tFg5DbKdDHefNZIt318zeigMDNd1nlMR3+o+7hLOjwoJs65LQjVFNzVnlBlwojCy
         kDxk2EdEYX9Hgzo4QG/86PABizpmGzPlF4P7ogcd/m5OV/Fv0kp/PQBFXpEtKX2TS0Ku
         9wG0mouaeMMU/Iee9CE/tAv9osLGtMH4FQn7+j7VM/RVs5IVEUHSEHVZTyva2vz53gth
         it5g==
X-Forwarded-Encrypted: i=1; AJvYcCU/29uJ0biFAA1yilDlj73Fsn20yJv1PtOLywdYD/+lhvRU1eKqoGROBh1p0Is53fW0b0e8+dwmp4GI8XhK@vger.kernel.org
X-Gm-Message-State: AOJu0YyrDtfkU9x7sNKw3PRWe23b5yjnBY6g6Z8ugbNf+rB5Gzbhd67d
	JkCDdtBID7KaWtbmKA2y+Gl5HCxltprHf7GQwMNS1x+Lvxp1VYPrkZMysItL/KgchmDBNw6Mvpp
	zT1oXF/PTmoTZvQ3WiUrE7o3AubuF3g==
X-Received: from dlbrl15.prod.google.com ([2002:a05:7022:f50f:b0:128:e0dc:644a])
 (user=samitolvanen job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7022:ec17:b0:12b:ebb8:e518 with SMTP id a92af1059eb24-12bfb779d53mr2038986c88.35.1775263032852;
 Fri, 03 Apr 2026 17:37:12 -0700 (PDT)
Date: Sat,  4 Apr 2026 00:37:07 +0000
In-Reply-To: <-v2-0-a3542e15111c@kernel.org>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <-v2-0-a3542e15111c@kernel.org>
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=936; i=samitolvanen@google.com;
 h=from:subject:message-id; bh=VRW7wRW2Q9r1frAdP8PWIidOriIPo2srmhCCTDv7jTw=;
 b=owGbwMvMwCUWxa662nLh8irG02pJDJkXYk1uVKzNUSjzucIeWGR4Kaws2zKGaV18b3fjQtFD1
 t1nZz7oKGVhEONikBVTZGn5unrr7u9Oqa8+F0nAzGFlAhnCwMUpABNZNYfhn/aR7wm1zjNk3Q2W
 77x94cOTlfsnHHm4ME5k9rwJNsfufrBkZFjN0Plo5sJ/zcwF8ZP+/GzrY9ebZxWSIFl15nLOrLz rzJwA
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <177526278781.1915281.2852116163003969353.b4-ty@google.com>
Subject: Re: [PATCH v2 0/2] module: Tweak return and warning
From: Sami Tolvanen <samitolvanen@google.com>
To: Luis Chamberlain <mcgrof@kernel.org>, Daniel Gomez <da.gomez@kernel.org>, 
	Lucas De Marchi <demarchi@kernel.org>
Cc: Sami Tolvanen <samitolvanen@google.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Aaron Tomlin <atomlin@atomlin.com>, 
	Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@samsung.com>, Phil Sutter <phil@nwl.cc>, 
	linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Christophe Leroy <chleroy@kernel.org>
Content-Type: text/plain; charset="utf-8"

On Mon, 30 Mar 2026 08:13:50 -0500, Lucas De Marchi wrote:
> Do not let userspace tools and end users confused on the return code and
> log messages.
> 
> To: Luis Chamberlain <mcgrof@kernel.org>
> To: Daniel Gomez <da.gomez@kernel.org>
> To: Sami Tolvanen <samitolvanen@google.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Aaron Tomlin <atomlin@atomlin.com>
> Cc: Petr Pavlu <petr.pavlu@suse.com>
> Cc: Daniel Gomez <da.gomez@samsung.com>
> Cc: Phil Sutter <phil@nwl.cc>
> Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
> Cc: linux-modules@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> 
> [...]

Applied to modules-next, thanks!

[1/2] module: Override -EEXIST module return
      commit: 743f8cae549affe8eafb021b8c0e78a9f3bc23fa
[2/2] module: Simplify warning on positive returns from module_init()
      commit: 663385f9155f27892a97a5824006f806a32eb8dc

Best regards,

	Sami


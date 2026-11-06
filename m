Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=45.157.188.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793950249;
	b=CoX18yUGqKOPuEQg3HnmBdf2WxOYOEYBc+A5Nd7SkdOMpi036z3TVfWwa+2nwyoManJs
	 RsywV8QVLo/9Li530KBnQf1o3R8oLK2tu06SF/cNCfy5tVOk9oJtSdLk9E4joymEddjvW
	 EXVNMZKR4dL5TAQDrZrHYFewkgWSGOtN9qbFuML6KEb2XQGZ1HX1rQyj299DEpgYyUSJX
	 Ycws7/cKxvlPQZgDwq7nZFtvwKv7gfjeT02dIHECBaLk6bACRGZwv9i0LAEncI5NSDuzA
	 zIuAoOzK3t/dOpEDj6IxPnVx9aWPJPYUII5EmCR3SAQpu8sTQl26m9dPeEoDMasaRww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793950249;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:To:Cc:
	 Date:Subject:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:X-Infomaniak-Routing;
	bh=6qwCT3Jvu8lkkM6R8PHy1mSFbjl1ytyEVmTgryXfzvQ=;
	b=XqkrFgq2dc8xBTDaQ0jJ5/mvE29janY7YIHDlhXwp2osD2qrBMsupN879iQkW7bctBbF
	 OREXj/K/ryxYTDhVQCglaLWD51ercOCNR5A8sKo8o9QmLP6aHgS0SU9DE29VBdyOoeme1
	 o0ioULvPaJ0RrtVYcXk6HGM4P9yforT013QdL9i2mGeUnc72xADhkWjcl/rryGhhMaUC6
	 FA04mlwAPTE/k++1r53bMOB+BuftiLDdYKUifJgHZMenMotKbarSS5W+vnDuN8JOkMdID
	 fR/+U+gD9sE1KK5UkIUdjIg1GgMAEEgbX1yPpMW1YxGeAZBV//o92SyR6E1MhWS66mw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=daylightlinux.ch;
	spf=pass smtp.mailfrom=daylightlinux.ch;
	dkim=pass header.d=daylightlinux.ch header.i=@daylightlinux.ch header.a=rsa-sha256 header.s=20261016 header.b=Jf5ysTyK;
	arc=none smtp.remote-ip=45.157.188.11
Received: from smtp-bc0b.mail.infomaniak.ch (smtp-bc0b.mail.infomaniak.ch [45.157.188.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30388606A328
	for <linux-modules@vger.kernel.org>; Fri,  6 Nov 2026 07:30:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 30388606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=daylightlinux.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=daylightlinux.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=daylightlinux.ch header.i=@daylightlinux.ch header.a=rsa-sha256 header.s=20261016 header.b=Jf5ysTyK
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch [10.7.10.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4jLW7B1N31zdCg;
	Fri,  6 Nov 2026 08:30:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=daylightlinux.ch;
	s=20261016; t=1793950245;
	bh=6qwCT3Jvu8lkkM6R8PHy1mSFbjl1ytyEVmTgryXfzvQ=;
	h=From:To:Cc:Date:Subject:In-Reply-To:References:From;
	b=Jf5ysTyKp+sZFhcUaqaZP/yJR3L9J4ttB5TNtUybjfbNZF/hM9rW+JlYELAyAXsYu
	 55cRDkfDVNNI1YrBu5Vf0MwaI5j60Ul40sUhtAkFSj6B93vWIAhChFjPGrEkD/amTs
	 ow8mSwCL/nSYaBnUazdPek2zNct3klAMzGaQf4zij6mp+nFK/oSSgzooMLQ8g9mewO
	 hx9J6cuuZ9m7avyywWx9sEdLQ/oALXovFg444QgzCX60INvseLCwD8uJKfyWrplYpl
	 87UiXx9c1CZkL+7boyLLzpn2MnaS4OW6yd1iIEEhNYo2V+MtUQf9ocVH5PGgmmKI7g
	 OJggACS81f/pA==
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4jLW79134bzWtq;
	Fri,  6 Nov 2026 08:30:45 +0100 (CET)
Received: from unknown by raspberrypi with local (Exim 4.96)
	(envelope-from <info@daylightlinux.ch>)
	id 1xPEPM-001IFH-2G;
	Fri, 06 Nov 2026 08:30:44 +0100
From: Hamdy Abou El Anein <info@daylightlinux.ch>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>,
 Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>,
 Aaron Tomlin <atomlin@atomlin.com>, linux-modules@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Fri, 06 Nov 2026 08:30:22 +0100
Subject: Re: [PATCH] kbuild: detect module name collisions between '-' and '_'
In-Reply-To: <179393591106.309869.2814629602029032688.b4-review@b4>
References: <20261103110411.11698-1-info@daylightlinux.ch>
 <179393591106.309869.2814629602029032688.b4-review@b4>
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Post: <mailto:linux-modules@vger.kernel.org>
List-Help: <mailto:linux-modules+help@vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-modules+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Message-Id: <E1xPEPM-001IFH-2G@raspberrypi>
X-Infomaniak-Routing: alpha

Hi Nathan,

Yes, it appears so. The module-name uniqueness check dates back to 2019 and compared basenames without normalizing '-' and '_', so this case seems to have been missed since its introduction.

Thanks for reviewing,
Hamdy

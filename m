Received: from mail.tuxedocomputers.com (mail.tuxedocomputers.com [157.90.84.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00B2ACA5B;
	Fri, 15 Nov 2024 13:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=157.90.84.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731675813; cv=none; b=Nmw4gvFvJV39ej/ZoxWJdX820uKu5XfXIMths9iqMm/6qvCbAMMF5SDMC1klH/wVGGeoaahGM2rPbeGMxlgd1QDF6yUPrGwNqvHvuj/DhBR+t9E9m4dEvYcJyKvEKok7WdBli4JW7qvTL+gxrQmGFllmDCdAepojEmKuKCVsgE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731675813; c=relaxed/simple;
	bh=G/aJnmBKpY1MsCYPsM+/BrpkaGoma8ST2yBIa28hsdQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=TWDTG1W7lLKImm7XrW5dvM0c38ThIWiye3BuXjlBO5pvoyx2jaQDrtjR4qxzC1U92R7B0lJ4ESzKVXEPEsEDSz3xhqvgGcxN8Ngs16fJpxZFQa2RKC9y05A/Uz4hBhbK0KLJ+v2pD07susqQbtu2ddH8AU9ME1RFjmbVWogYWsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com; spf=pass smtp.mailfrom=tuxedocomputers.com; dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b=iokk2y2T; arc=none smtp.client-ip=157.90.84.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxedocomputers.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b="iokk2y2T"
Received: from [192.168.42.96] (p5de457db.dip0.t-ipconnect.de [93.228.87.219])
	(Authenticated sender: wse@tuxedocomputers.com)
	by mail.tuxedocomputers.com (Postfix) with ESMTPSA id C95A82FC0057;
	Fri, 15 Nov 2024 14:03:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tuxedocomputers.com;
	s=default; t=1731675808;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G/aJnmBKpY1MsCYPsM+/BrpkaGoma8ST2yBIa28hsdQ=;
	b=iokk2y2TfoIUOwM2aLQWNeXjJZKhciecbOwukciqaDZI2bpBUIKcuATSh/kgQPXWoo1zgZ
	6JF89fZRZ46tQO47wc8bxRYpr2+BuMetJL9siYv/8n5KFLIfBY0fgjaS9YrjWoY6ks6la6
	Pu0dulYKzOMflfZjpk+x9BHpt+4P+qU=
Authentication-Results: mail.tuxedocomputers.com;
	auth=pass smtp.auth=wse@tuxedocomputers.com smtp.mailfrom=wse@tuxedocomputers.com
Message-ID: <3023bbda-0902-4e5c-aeb1-074623cd8ff0@tuxedocomputers.com>
Date: Fri, 15 Nov 2024 14:03:27 +0100
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] module: Block some modules by TUXEDO from
 accessing
To: u.kleine-koenig@baylibre.com, mcgrof@kernel.org, petr.pavlu@suse.com,
 samitolvanen@google.com, da.gomez@samsung.com,
 linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux@leemhuis.info, vv@tuxedocomputers.com, cs@tuxedo.de
References: <20241115130139.1244786-1-wse@tuxedocomputers.com>
Content-Language: en-US
From: Werner Sembach <wse@tuxedocomputers.com>
In-Reply-To: <20241115130139.1244786-1-wse@tuxedocomputers.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Am 15.11.24 um 13:58 schrieb Werner Sembach:
> Following the meeting I wrote about yesterday, I now changed the license
> of what we could change spontaniously to prove good faith.
>
> I still hope that the rest can be sorted out before anything gets merged.
> We are working on it. A clear time window would still be helpfull.
>
> At Uwe. I don't know how it works if you modifiy someone elses code. I
> removed the Signed-off-by: line and I guess you have to add it again?
>
> v2: Removed modules that could and have been spontaniously relicensed
> v3: Fix typo and remove untrue assumption while giving more context
>
Wrong version in the cover letter, but should be no problem should it?

I need to grab lunch ...



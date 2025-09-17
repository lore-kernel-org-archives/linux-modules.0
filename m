Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7478D1C84C0;
	Wed, 17 Sep 2025 17:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758131905; cv=none; b=ZXcUrpssm+B3r8SbE8yYQiP4dwnGBl3oYdLbwY12hCQF0C+rgW6RFxnQSkOAR8m9VYWBAmpjcsL1CXit7OST0g1cSiVr7TxgqGrM0ijMxxm2crcPjjQ0h1sY9+iijzKBwfE5e+YiLpwCusnfj4kpfNzsXBWj0MGnZobU3F3H5Po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758131905; c=relaxed/simple;
	bh=6zMlqvkkJUxPR+2hCntCFeaA3Ngj3U6itSCfgav3eEY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ERx5V9Fwb0VL/W0jGpTMrwbmUs0k0tXKZEUXHM2SbxBQeWOibwqNELnp7pwT20wTsqdzFZNfd96KhZY4GYbOSr5iGaKIVk6BoqOpa9/fQNOP+Z/dg/dV0D7spO+PwxP1RM0lYo0gJeBdfkx8nDQKrKjPn+n9/T2c2e5Rc03NINA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ST1KfL37; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ST1KfL37"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=4sg0pwVlDI3PlcEWg3BqiWrpfnSRU0MPr0hgbDjPw6w=; b=ST1KfL37z8LSxRSVV7aGFKe8Z9
	u2ZfkpoxZX0BcWKZNcx6GOPpjZwYIB/ijc7R9rMKCezRU7vYQZSHesfNQuvqzzDRDnQoT/vsjpOtn
	FhGLzQdSUzYoJ1H1dBn0Vl3blJwnwaX6a8aHl/ONmnuWqRv1WAR+aLAQvf6w2IPcMJpI07Bo+fsVY
	UsG0cA7voaF7RMUFkdf/tY5BTr/10CY+zxBKKhgTSGtM/gHixBteOuTEofuJ05ckY7Sqfr36beljR
	I8aGbN5mwE+13QVhKPlYZl1KP9R/V26NlEwdxPsvjFCrAsZU+9y0JWa8eqVFO4PhH1DRidVpjeKnG
	4c5yfdXw==;
Received: from [50.53.25.54] (helo=[192.168.254.17])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uywQ6-0000000DlSR-48eJ;
	Wed, 17 Sep 2025 17:58:19 +0000
Message-ID: <9c459c3f-7a7b-42d6-8a4c-66ade94e1029@infradead.org>
Date: Wed, 17 Sep 2025 10:58:17 -0700
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] ALSA: doc: add docs about
 device_device_quirk_flags in snd-usb-audio
To: cryolitia@uniontech.com, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, Jonathan Corbet <corbet@lwn.net>,
 Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>,
 Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>
Cc: linux-sound@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 Mingcong Bai <jeffbai@aosc.io>, Kexy Biscuit <kexybiscuit@aosc.io>,
 Nie Cheng <niecheng1@uniontech.com>, Zhan Jun <zhanjun@uniontech.com>,
 Feng Yuan <fengyuan@uniontech.com>, qaqland <anguoli@uniontech.com>,
 kernel@uniontech.com, linux-modules@vger.kernel.org
References: <20250917-sound-v3-0-92ebe9472a0a@uniontech.com>
 <20250917-sound-v3-4-92ebe9472a0a@uniontech.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20250917-sound-v3-4-92ebe9472a0a@uniontech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/17/25 5:46 AM, Cryolitia PukNgae via B4 Relay wrote:
> @@ -2344,8 +2386,8 @@ report it to the upstream.
>  NB: ``quirk_alias`` option is provided only for testing / development.
>  If you want to have a proper support, contact to upstream for
>  adding the matching quirk in the driver code statically.
> -Ditto for ``quirk_flags``.  If a device is known to require specific
> -workarounds, please report to the upstream.
> +Ditto for ``quirk_flags``.  If a device
> +is known to require specific workarounds, please report to the upstream.

What is the purpose of this change?

-- 
~Randy


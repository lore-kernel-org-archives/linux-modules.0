Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E49232EBBB2;
	Wed, 17 Sep 2025 13:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758115682; cv=none; b=onK+IeOcY7EjfuBxNhxpGK/FiA6a5N6Vsl5X9VJonz4y0cpsgLimbGWf9zRt24wLmgjug6UkjoHogIsohwYms8rEF0JJoRI85A1m+jrtwm5ZyV9FLShZkRanz04DXnqeMnO8ElIgTcfsjFg4dT4ECi1qX4MMde1ylhDdUjRlHWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758115682; c=relaxed/simple;
	bh=TiTzmMbR5nva4akgdNhgMpzqQgt4sNgYMEMrUKSoyiU=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=quOi9iv5XE+FC9YwJWxAgve3bsGGyVxmPeMc+YDESQipQz7MgkCsS0M4yEH7LGUd/CrxWp8xwSTr7NpZKxA58/eBhArelrzKDrNrCTEeu25HRR1BxFQY7BUTBbXRskhQqv438iDwybkwTE2k92XVjgwY2i3ZW1X526rW2sPBJkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=Y4JWp/2/; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="Y4JWp/2/"
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1758115677;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wERivNMnB7eyGntxtjltf/WH53+pKFmfMOZ0+81HSi4=;
	b=Y4JWp/2/8qybWiWVyBBAr7DIDnnvKPO+mKw5TTfmz4gXivTD5MnRKB1N1oQBZCP4jlMWaR
	jThSbsXYMd+q4x7KwzGOOGfUndQaHovo+K4AmzYZbdFKhPSGY7cJH6vHkgJxuTkrskqcQ8
	gUIgM1DpeCalLw9BiGBoO8WExfhzJs3anjlnny1Dw0dzVmJ2WIe5Ne7IywOi49yAfnoR4i
	1dL6ClzJbXfY7jJI53Aayl0P0X+lwbUZyZYuRGMg14wYBL4T1fcrQ813gwpYply7KjM4/W
	MwpLWMZr+4iybDPZ6FsmJSXg/bunueDYUFRjVReIR3n7IYrBKXIF5vEbAAkJdg==
Date: Wed, 17 Sep 2025 15:27:56 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: cryolitia@uniontech.com
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Jonathan Corbet <corbet@lwn.net>, Luis Chamberlain <mcgrof@kernel.org>, Petr
 Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>, Sami
 Tolvanen <samitolvanen@google.com>, linux-sound@vger.kernel.org,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, Mingcong Bai <jeffbai@aosc.io>, Kexy Biscuit
 <kexybiscuit@aosc.io>, Nie Cheng <niecheng1@uniontech.com>, Zhan Jun
 <zhanjun@uniontech.com>, Feng Yuan <fengyuan@uniontech.com>, qaqland
 <anguoli@uniontech.com>, kernel@uniontech.com, linux-modules@vger.kernel.org
Subject: Re: [PATCH v3 4/4] ALSA: doc: add docs about
 device_device_quirk_flags in snd-usb-audio
In-Reply-To: <20250917-sound-v3-4-92ebe9472a0a@uniontech.com>
References: <20250917-sound-v3-0-92ebe9472a0a@uniontech.com>
 <20250917-sound-v3-4-92ebe9472a0a@uniontech.com>
Message-ID: <0999abc5390bbfcb21e15bd140510540@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Cryolitia,

On 2025-09-17 14:46, Cryolitia PukNgae via B4 Relay wrote:
> From: Cryolitia PukNgae <cryolitia@uniontech.com>
> 
> Just briefly described about the new option.
> 
> Signed-off-by: Cryolitia PukNgae <cryolitia@uniontech.com>

Isn't the patch subject a bit wrong, and should contain
"device quirk_flags" instead of "device_device_quirk_flags"?

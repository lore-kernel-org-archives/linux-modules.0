Received: from mail.tuxedocomputers.com (mail.tuxedocomputers.com [157.90.84.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C11E154C00;
	Fri, 15 Nov 2024 11:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=157.90.84.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731668509; cv=none; b=lpiYSZzmv4oYinXqjf22UxMeGDF23IJze31tPUlMdnSIZktxYhFm01Jzj3xEIHbGyF/q6aJ34JRGYwf7ieynkPHKL6Tg5fhxpAkebCY8V4SRA6E4D3+oxHmt9Fp/XI1ZOfdhqYjsmV4ZI8sJOmVZ3sVtnSuiSoxDIWKt2EqjdnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731668509; c=relaxed/simple;
	bh=m7BVGvXyT71CEXI4yUkoMGjzzQM/AEOtiUKWoG93h/A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EQc4GyNxE8415gxVA4lv9uYrSareNujHf+2pBq4qVRSE5IwKhcCIUWAmU2klNFvrSouy1mjJjfth0BNVRjGGINiRI5w/QXNMo03ta77JVStY2AXiXgs0vEblJ9q1g+/SG5h2N9DghBhMfBtcsAc9Mu1cjrXZn2DOnBkhAa5sp1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com; spf=pass smtp.mailfrom=tuxedocomputers.com; dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b=Iux2gwX6; arc=none smtp.client-ip=157.90.84.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxedocomputers.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b="Iux2gwX6"
Received: from [192.168.42.96] (p5de457db.dip0.t-ipconnect.de [93.228.87.219])
	(Authenticated sender: wse@tuxedocomputers.com)
	by mail.tuxedocomputers.com (Postfix) with ESMTPSA id DA0F82FC0057;
	Fri, 15 Nov 2024 12:01:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tuxedocomputers.com;
	s=default; t=1731668504;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cY/MafceW9ixF9GLI0m9zzx5gRSTc4nzvb8Dcslkwyw=;
	b=Iux2gwX62e5wze1PTeurUKw63gE5CCyShDNJL0459p8btp12VCXfhe+DHDQ2zoQPVuLLRI
	D2eeQsLjpk4GHUbNxFSOq12yXJ9x3nkZ71yXaiGwcwt7DUSLjFTLg9bv8jr59rxuv9qXh0
	auIpj2pTdj86GE7pxwn2CiVVKL0eo+g=
Authentication-Results: mail.tuxedocomputers.com;
	auth=pass smtp.auth=wse@tuxedocomputers.com smtp.mailfrom=wse@tuxedocomputers.com
Message-ID: <9e498b77-acfc-4aca-9734-16d5829518d4@tuxedocomputers.com>
Date: Fri, 15 Nov 2024 12:01:43 +0100
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] module: Block modules by Tuxedo from accessing GPL
 symbols
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, Luis Chamberlain
 <mcgrof@kernel.org>, tux@tuxedocomputers.com,
 Petr Pavlu <petr.pavlu@suse.com>, Sami Tolvanen <samitolvanen@google.com>,
 Daniel Gomez <da.gomez@samsung.com>, linux-modules@vger.kernel.org,
 linux-kernel@vger.kernel.org, Thorsten Leemhuis <linux@leemhuis.info>,
 Vinzenz Vietzke <vv@tuxedocomputers.com>, Christoffer Sandberg <cs@tuxedo.de>
References: <20241114103133.547032-4-ukleinek@kernel.org>
 <e32e9f5c-3841-41f7-9728-f998f123cc8a@tuxedocomputers.com>
 <2024111557-unlighted-giggle-0d86@gregkh>
 <6c1952bc-f58d-4c55-887e-6aa247daec5c@tuxedocomputers.com>
 <h5q36ajuzgwf5yrjmqv46x62evifcgoi5imxhcvsv7oxauvxak@sj54oisawqnf>
 <58b85a78-55aa-422c-a21d-254eb16cc8c6@tuxedocomputers.com>
 <2024111522-brush-excusably-cae5@gregkh>
 <3ea99d52-cafb-4c79-a78b-fdd1f9a9fcd5@tuxedocomputers.com>
 <y3lspnzleavkgvujrf66rly65yw3sskjomcvbginijgexaybys@bg53hyadhcbw>
Content-Language: en-US
From: Werner Sembach <wse@tuxedocomputers.com>
In-Reply-To: <y3lspnzleavkgvujrf66rly65yw3sskjomcvbginijgexaybys@bg53hyadhcbw>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


Am 15.11.24 um 11:51 schrieb Uwe Kleine-König:
> Hello Werner,
>
> On Fri, Nov 15, 2024 at 10:40:56AM +0100, Werner Sembach wrote:
>> Then why does the proprietary NVIDIA driver exist?
> Please don't use NVIDIA's behaviour as a blueprint for your actions.
> INAL, but I would not recommend to deduce from "NVIDIA does it and
> wasn't tried to stop" (for any value of "it") that "it" is legal, honest
> and in line with the open source spirit.
Ofc I don't want to use NVIDIA's behavior as a blueprint, it was just to show 
where my misconception stems from.
>
> Best regards
> Uwe

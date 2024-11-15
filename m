Received: from mail.tuxedocomputers.com (mail.tuxedocomputers.com [157.90.84.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4161190468;
	Fri, 15 Nov 2024 09:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=157.90.84.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731663663; cv=none; b=fTmrWLJ9zkk885dFQHeN430FW/G6Sqw4Wwxiv82Ih1T68ifaebNTaC7bO569ZcBcw6KXPnjO1B8DdxiSvC3kAjfmOXozn7QIQox6tjWszaqCDhg6AxmwVXStxFRJpqun1IKIKxNT9wQtmdrIXzo99H6j31D3mxBsW5+HIJr/2gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731663663; c=relaxed/simple;
	bh=DhIh0e33nWUyDev3Jch1s8YrhbuT4Nydp2hlrdmM0JQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qGLdl1xJiMMSAogSSl1Ksj2wvI9JAHyK+3qHVSHOrmR/63jK7qy4NT6wUXklgFeNNzIRkL/7R+GUonQgByJkFbLg0t9eINmTJojm0y8Buag3IYRidJ2zCDvKWrOhRJO4zmAgtljGN/ctG4c3HaYzv198w+gW5Be+yoHXaV4R0uY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com; spf=pass smtp.mailfrom=tuxedocomputers.com; dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b=MDrdPek7; arc=none smtp.client-ip=157.90.84.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxedocomputers.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b="MDrdPek7"
Received: from [192.168.42.96] (p5de457db.dip0.t-ipconnect.de [93.228.87.219])
	(Authenticated sender: wse@tuxedocomputers.com)
	by mail.tuxedocomputers.com (Postfix) with ESMTPSA id 831F92FC0057;
	Fri, 15 Nov 2024 10:40:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tuxedocomputers.com;
	s=default; t=1731663657;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OFukgKvCJJohyeiFlhpMtmGg5pydgykofogssL94ge0=;
	b=MDrdPek72n3sQLdZ2kX3coEnfJf/SY1gyAFcKxv/xZLnWN1ldFKdp7PbRq5YWCaNdH/daS
	erNpfugXBAlha/KnJ1x1ZhOtmhznMCoCFD0xySnUulNyuBsv7BmRo3duhxYKkxHq8ijPmW
	wkZKud/AXlguWs5zvKp6Wl5L1T/qKO4=
Authentication-Results: mail.tuxedocomputers.com;
	auth=pass smtp.auth=wse@tuxedocomputers.com smtp.mailfrom=wse@tuxedocomputers.com
Message-ID: <3ea99d52-cafb-4c79-a78b-fdd1f9a9fcd5@tuxedocomputers.com>
Date: Fri, 15 Nov 2024 10:40:56 +0100
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] module: Block modules by Tuxedo from accessing GPL
 symbols
To: Greg KH <gregkh@linuxfoundation.org>
Cc: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 Luis Chamberlain <mcgrof@kernel.org>, tux@tuxedocomputers.com,
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
Content-Language: en-US
From: Werner Sembach <wse@tuxedocomputers.com>
In-Reply-To: <2024111522-brush-excusably-cae5@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


Am 15.11.24 um 10:18 schrieb Greg KH:
> On Fri, Nov 15, 2024 at 10:00:23AM +0100, Werner Sembach wrote:
>> I guess what I try to convince you and others is that we _are_ taking Open
>> Source licenses seriously, but still there are mistakes to be made,
>> especially with complex projects like the Linux kernel, e.g. I'm not aware
>> of any other project that uses a similar construct to
>> EXPORT_SYMBOL_GPL()/MODULE_LICENSE().
> The Linux kernel is very simple from a license point of view, your code
> has to be GPLv2 compatible.  That's it, nothing complex or odd about
> that at all.
Then why does the proprietary NVIDIA driver exist?
>
> thanks,
>
> greg k-h

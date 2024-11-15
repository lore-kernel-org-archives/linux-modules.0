Received: from mail.tuxedocomputers.com (mail.tuxedocomputers.com [157.90.84.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D2631885BF;
	Fri, 15 Nov 2024 10:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=157.90.84.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731668395; cv=none; b=Ky/xiLuS4r+Z7oOCWKYFUIBetams8Nizh0VjHNI/lWLcnq3tvE3gg/IavC2tWcJVwI0W0cz5lR7dTxlrPU5cA536UPG+KZ5XFgrpU74O+MO15LAOEgELeTUgTjEHiaoY6jv3bBGXaTygwFCTjVFC3S9cKT9zdk3P+oR9o6iZVsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731668395; c=relaxed/simple;
	bh=KPPxSUlglSB1qHziPJ8WC9R7TbOyfCrf4T3tNsWVcHE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=auQmZxA5L5wFkkylqkLMdUF/xSD6x0N1ODIcf2ZypSB2y1YHvTJmBf9hXHvMsifgXJkWrweJ1X5UBsejnXLL/TKPd8R8IkYqJ96rg8Ho2XO++W+QwZa81wnsgfSSg/TmT+592K61JOzey15XQo4+RgJdK+blopoEGN6BI0Kcro8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com; spf=pass smtp.mailfrom=tuxedocomputers.com; dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b=K7yEh3pX; arc=none smtp.client-ip=157.90.84.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxedocomputers.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b="K7yEh3pX"
Received: from [192.168.42.96] (p5de457db.dip0.t-ipconnect.de [93.228.87.219])
	(Authenticated sender: wse@tuxedocomputers.com)
	by mail.tuxedocomputers.com (Postfix) with ESMTPSA id 25EBF2FC0057;
	Fri, 15 Nov 2024 11:59:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tuxedocomputers.com;
	s=default; t=1731668388;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MbaHCdErIiwuDwefIUo/nmxCO9zrzvR9WvqIorv/FfI=;
	b=K7yEh3pXs/RNYbj3dG5RS0Hybw7C4ttrWfe4BY/AO/8tKkSDqXQ16XTLOCFrAUNZxtC6dt
	lhsQLzGfj1NG2u3aaAvgi8/3/Bx6rLh99ReJb0xh8z+7tOqXHDd6j+nQEWJoZ1TgflWJzX
	3DWD3ldw3k4Gy+1QqI/SeS3ncmGIE6A=
Authentication-Results: mail.tuxedocomputers.com;
	auth=pass smtp.auth=wse@tuxedocomputers.com smtp.mailfrom=wse@tuxedocomputers.com
Message-ID: <459e15ff-4f1f-4d7c-b49d-ccae540eaa4f@tuxedocomputers.com>
Date: Fri, 15 Nov 2024 11:59:47 +0100
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
 <3ea99d52-cafb-4c79-a78b-fdd1f9a9fcd5@tuxedocomputers.com>
 <2024111558-albatross-vice-2a73@gregkh>
Content-Language: en-US
From: Werner Sembach <wse@tuxedocomputers.com>
In-Reply-To: <2024111558-albatross-vice-2a73@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


Am 15.11.24 um 11:22 schrieb Greg KH:
> On Fri, Nov 15, 2024 at 10:40:56AM +0100, Werner Sembach wrote:
>> Am 15.11.24 um 10:18 schrieb Greg KH:
>>> On Fri, Nov 15, 2024 at 10:00:23AM +0100, Werner Sembach wrote:
>>>> I guess what I try to convince you and others is that we _are_ taking Open
>>>> Source licenses seriously, but still there are mistakes to be made,
>>>> especially with complex projects like the Linux kernel, e.g. I'm not aware
>>>> of any other project that uses a similar construct to
>>>> EXPORT_SYMBOL_GPL()/MODULE_LICENSE().
>>> The Linux kernel is very simple from a license point of view, your code
>>> has to be GPLv2 compatible.  That's it, nothing complex or odd about
>>> that at all.
>> Then why does the proprietary NVIDIA driver exist?
> You will have to discuss that with that company's lawyers.  That was
> their business decision to make, and in my opinion, the contracts they
> wrote around that thing were a mastery of license law in "how to pass
> the liability onto someone else."
But you see where there is complexity, and where my misconception stems from?
>
> Luckily we now have open drivers for almost all of that hardware, so
> it's not so much of an issue anymore.
>
> Again, talk about this with your company lawyers, they can explain it
> all much better than I can.
>
> thanks,
>
> greg k-h

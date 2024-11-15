Received: from mail.tuxedocomputers.com (mail.tuxedocomputers.com [157.90.84.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD8381714C0;
	Fri, 15 Nov 2024 06:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=157.90.84.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731650996; cv=none; b=PdNT3HT5KnfhDzXNugnPw3/pD6DT10RkKl4d+e34/gfRItDnRMtnfkdS6ByUL5NT8bB9rduSbz27vRJ9yKQxKvlDjYSoWJ+kJZgB+oLZY4WfZMibfcXc3f2uuwW2I85R53cuz2tgAc+x1xKgdh150tpRRL8njF5QuOK6KYpiOS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731650996; c=relaxed/simple;
	bh=FGGNcx7I3mGtUqTVbToHaEKMQVbJ2MZmuzf2h0ZTS1Q=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=X9CCNpRnb+d+Q1J7i/XOBbiC8EUR6K1tAV8yweP5Z9ekURxoTTn/hTw+YGHR7uGgjgdReSBdeV9hjrq8WkggOHWieiJSeczVWq8RvJTMtYP/4mQLoesjmsPPt/fvXpBhVMJzkVFoNrbRuH0MEpv52Av8CmEQlpBMkD+5PtGikyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com; spf=pass smtp.mailfrom=tuxedocomputers.com; dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b=Kts1Ttn5; arc=none smtp.client-ip=157.90.84.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxedocomputers.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b="Kts1Ttn5"
Received: from [192.168.42.96] (p5de457db.dip0.t-ipconnect.de [93.228.87.219])
	(Authenticated sender: wse@tuxedocomputers.com)
	by mail.tuxedocomputers.com (Postfix) with ESMTPSA id B293F2FC0057;
	Fri, 15 Nov 2024 07:09:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tuxedocomputers.com;
	s=default; t=1731650990;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gVcTWV1ZxqzFsXWw2RidADJTa1JW3HgSR3aeNVGYKFY=;
	b=Kts1Ttn5UtoSUvpNxkhfc0zu9x6jzGvTrerZCr5ImbF1lHTrM8RTLvGsVemP0Z8yZoiqbn
	RpOF5Itv8Yk8Um2w/35eQRVuR2L1LEkxbOs5Hfca/gviXNBYn+mr4mYGQX+ZvZXCLkz3Xl
	5u30x8GmNxSibPIu2g63P0U/SPQcWig=
Authentication-Results: mail.tuxedocomputers.com;
	auth=pass smtp.auth=wse@tuxedocomputers.com smtp.mailfrom=wse@tuxedocomputers.com
Message-ID: <6c1952bc-f58d-4c55-887e-6aa247daec5c@tuxedocomputers.com>
Date: Fri, 15 Nov 2024 07:09:49 +0100
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Werner Sembach <wse@tuxedocomputers.com>
Subject: Re: [PATCH 0/2] module: Block modules by Tuxedo from accessing GPL
 symbols
To: Greg KH <gregkh@linuxfoundation.org>
Cc: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
 Luis Chamberlain <mcgrof@kernel.org>, tux@tuxedocomputers.com,
 Petr Pavlu <petr.pavlu@suse.com>, Sami Tolvanen <samitolvanen@google.com>,
 Daniel Gomez <da.gomez@samsung.com>, linux-modules@vger.kernel.org,
 linux-kernel@vger.kernel.org, Thorsten Leemhuis <linux@leemhuis.info>
References: <20241114103133.547032-4-ukleinek@kernel.org>
 <e32e9f5c-3841-41f7-9728-f998f123cc8a@tuxedocomputers.com>
 <2024111557-unlighted-giggle-0d86@gregkh>
Content-Language: en-US
In-Reply-To: <2024111557-unlighted-giggle-0d86@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

Am 15.11.24 um 05:43 schrieb Greg KH:
> On Thu, Nov 14, 2024 at 11:49:04AM +0100, Werner Sembach wrote:
>> Hello,
>>
>> Am 14.11.24 um 11:31 schrieb Uwe Kleine-König:
>>> Hello,
>>>
>>> the kernel modules provided by Tuxedo on
>>> https://gitlab.com/tuxedocomputers/development/packages/tuxedo-drivers
>>> are licensed under GPLv3 or later. This is incompatible with the
>>> kernel's license and so makes it impossible for distributions and other
>>> third parties to support these at least in pre-compiled form and so
>>> limits user experience and the possibilities to work on mainlining these
>>> drivers.
>>>
>>> This incompatibility is created on purpose to control the upstream
>>> process. Seehttps://fosstodon.org/@kernellogger/113423314337991594 for
>>> a nice summary of the situation and some further links about the issue.
>>>
>>> Note that the pull request that fixed the MODULE_LICENSE invocations to
>>> stop claiming GPL(v2) compatibility was accepted and then immediately
>>> reverted "for the time being until the legal stuff is sorted out"
>>> (https://gitlab.com/tuxedocomputers/development/packages/tuxedo-drivers/-/commit/a8c09b6c2ce6393fe39d8652d133af9f06cfb427).
>> As already being implied by that commit message, this is sadly not an issue
>> that can be sorted out over night.
>>
>> We ended up in this situation as MODULE_LICENSE("GPL") on its own does not
>> hint at GPL v2, if one is not aware of the license definition table in the
>> documentation.
> That's why it is documented, to explain this very thing.  Please don't
> suggest that documenting this is somehow not providing a hint.  That's
> just not going to fly with any lawyer who reads any of this, sorry.

You are right, that's why when I became aware of the situation this Monday 
https://gitlab.com/tuxedocomputers/development/packages/tuxedo-drivers/-/commit/9db67459510f18084694c597ff1ea57ef1842f4e 
I got the gears to resolve this into moving (me playing devils advocate here is 
directly related to this 
https://lore.kernel.org/all/17276996-dcca-4ab5-a64f-0e76514c5dc7@tuxedocomputers.com/) 
and then returned on working on the code rewrite for upstream ( 
https://lore.kernel.org/all/8847423c-22ec-4775-9119-de3e0ddb5204@tuxedocomputers.com/ 
is directly related to that), because I'm a developer not a lawyer.

Then I get called a liar and hit with the nuclear option not even full 3 days 
later, while I'm working on resolving the issue and in parallel working on 
improving the code for it to be actually accepted by upstream.

If you want prove of my blissful ignorance from just last week please take a 
look at my comment here: 
https://gitlab.com/tuxedocomputers/development/packages/tuxedo-drivers/-/merge_requests/21#note_2201702758

Now trying to be constructive: Can you give me a timeframe to resolve the 
license issue before this is merged?

Kind regards,

Werner Sembach

> greg k-h

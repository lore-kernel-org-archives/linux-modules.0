Received: from mail.tuxedocomputers.com (mail.tuxedocomputers.com [157.90.84.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B42EA1F77BF;
	Thu, 14 Nov 2024 11:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=157.90.84.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731584662; cv=none; b=k/YRmYvo/9D4c9WdOqYj34iUjo1+5XeS/Ige8vPOX+D6+q5e2ToMQziC+sDjp0ShW99euoMg+vsurgJ3P/UHyb3hvivit8YI9LoBSf+q+P08QNb2WF2d6vr3DMzs3IaNbcARxidHGpsqMFTUsJwiHg+Q4p0oyh9aAFQKPpAeRww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731584662; c=relaxed/simple;
	bh=36TpTDrJm3vRUum87tAmdtBGJCbKOOeB1ak12csyJqM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FbO6yShY5sIrED+cb0ilm06txPExExL2l8oQsknEsPxrg6X2R0CNNQBGbWs6EIdNk5fFlZ4bicfRS/5IevQoFsGH0XDpFtOe374nRCHRkx2DhkHfUGEQj4Bm4V4QK/ZGiv/wrlPVVNh/I9Kdhw4OmTHhFNZSO75H4m+oIRdpCA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com; spf=pass smtp.mailfrom=tuxedocomputers.com; dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b=OPDAA2uf; arc=none smtp.client-ip=157.90.84.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxedocomputers.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b="OPDAA2uf"
Received: from [192.168.42.96] (p5de457db.dip0.t-ipconnect.de [93.228.87.219])
	(Authenticated sender: wse@tuxedocomputers.com)
	by mail.tuxedocomputers.com (Postfix) with ESMTPSA id 86DDB2FC0050;
	Thu, 14 Nov 2024 12:44:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tuxedocomputers.com;
	s=default; t=1731584652;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kbS4/iXx9aVrajazwwhi8q7MzisqUawCI2x+4aG3FIE=;
	b=OPDAA2ufPXXMhlINJkUEmE7gnFE7C9mUcoHrrfdafUkohBg1B0Zeom/4P6XfT9ngezIQgZ
	fAhBrq78p2nSNiW/xRi2K/Z4aO0rBnp30kFRpxj0F8gNMRfPAJ1nj9R51DgQLMxz3A2kdM
	fQcPUhTunvUGLq4CNWXpQ9Lr8fdV9O4=
Authentication-Results: mail.tuxedocomputers.com;
	auth=pass smtp.auth=wse@tuxedocomputers.com smtp.mailfrom=wse@tuxedocomputers.com
Message-ID: <f7f8fa08-004b-4092-a4df-90cac8e325e2@tuxedocomputers.com>
Date: Thu, 14 Nov 2024 12:44:11 +0100
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] module: Block modules by Tuxedo from accessing GPL
 symbols
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
 Luis Chamberlain <mcgrof@kernel.org>
Cc: tux@tuxedocomputers.com, Petr Pavlu <petr.pavlu@suse.com>,
 Sami Tolvanen <samitolvanen@google.com>, Daniel Gomez
 <da.gomez@samsung.com>, linux-modules@vger.kernel.org,
 linux-kernel@vger.kernel.org, Thorsten Leemhuis <linux@leemhuis.info>
References: <20241114103133.547032-4-ukleinek@kernel.org>
 <e32e9f5c-3841-41f7-9728-f998f123cc8a@tuxedocomputers.com>
 <e7d97b3d-1880-4c89-bbf2-a742d6ac9e6b@kernel.org>
Content-Language: en-US
From: Werner Sembach <wse@tuxedocomputers.com>
In-Reply-To: <e7d97b3d-1880-4c89-bbf2-a742d6ac9e6b@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello,

Am 14.11.24 um 12:14 schrieb Uwe Kleine-König:
> Hello,
>
> On 11/14/24 11:49, Werner Sembach wrote:
>> Am 14.11.24 um 11:31 schrieb Uwe Kleine-König:
>>> the kernel modules provided by Tuxedo on
>>> https://gitlab.com/tuxedocomputers/development/packages/tuxedo-drivers
>>> are licensed under GPLv3 or later. This is incompatible with the
>>> kernel's license and so makes it impossible for distributions and other
>>> third parties to support these at least in pre-compiled form and so
>>> limits user experience and the possibilities to work on mainlining these
>>> drivers.
>>>
>>> This incompatibility is created on purpose to control the upstream
>>> process. See https://fosstodon.org/@kernellogger/113423314337991594 for
>>> a nice summary of the situation and some further links about the issue.
>>>
>>> Note that the pull request that fixed the MODULE_LICENSE invocations to
>>> stop claiming GPL(v2) compatibility was accepted and then immediately
>>> reverted "for the time being until the legal stuff is sorted out"
>>> (https://gitlab.com/tuxedocomputers/development/packages/tuxedo- 
>>> drivers/-/commit/a8c09b6c2ce6393fe39d8652d133af9f06cfb427).
>>
>> As already being implied by that commit message, this is sadly not an issue 
>> that can be sorted out over night.
>>
>> We ended up in this situation as MODULE_LICENSE("GPL") on its own does not 
>> hint at GPL v2, if one is not aware of the license definition table in the 
>> documentation.
>
> That statement isn't consistent with you saying to pick GPLv3 as an explicitly 
> incompatible license to control the mainlining process. So you knew that it's 
> legally at least questionable to combine these licenses.
Put in the time-dimension and you can figure out where this isn't inconsistent.
>
> The only thing I could accept here is that you were surprised that the 
> incompatibility has some technical enforcement resulting in your modules to 
> become nonfunctional. But that's like a thieve in a supermarket who asks for 
> forgiveness because while he was aware that steeling is not allowed, wasn't 
> aware there is video surveillance that might actually catch him.
>
> So I'd claim MODULE_LICENSE("GPL") not being explicit to not apply for GPLv3 
> code is not a valid excuse. (Which doesn't mean the kernel couldn't improve 
> here.)

I can not tell anything else than I wrote above so I probably can't gain your 
trust that it was an honest mistake.

Thing is we are working on rewriting the driver bit by bit directly for upstream 
under GPL v2, e.g. 
https://lore.kernel.org/all/20241001180658.76396-2-wse@tuxedocomputers.com/

And we don't stop anyone else from doing so and actively involve ourself in the 
process, giving advice where we can from our experience with the devices, e.g. 
https://github.com/Wer-Wolf/uniwill-laptop/issues/1

And tuxedo-drivers got code in the past from external contributors under GPL v3 
that also weren't aware of the correct definition of MODULE_LICENSE("GPL") which 
needs to be sorted out.

And no tuxedo-drivers module would get accepted upstream as is at the moment, 
because the focus of the driver package is mainly to get support for new devices 
out as quickly as possible, while upstream rightfully has way stricter 
guidelines on code quality (not implying that tuxedo-drivers has bad code 
quality, it's a spectrum after all).

What I want to say: If the end goal is upstream support for our devices nothing 
is speed up by the relicensing, arguably it's slowed down because someone now 
has to sort out legal stuff. If you want to take on the actual coding work 
yourself, please do so, I will give you advice as I did with Armins uniwill 
laptop driver and several times on the mailing list.

Kind regards,

Werner Sembach

>
> Best regards
> Uwe

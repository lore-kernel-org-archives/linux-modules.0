Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C22C19F113;
	Mon, 11 Nov 2024 18:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731351361; cv=none; b=M64MUsLEAf3IgB1t8SBi15Oa9eWN2WOUQcaxKWIL1shtgEBy+zunEsDueDahWbffruIaTEP/HwOW62MpcomRQ/FOo3+CrSDoAeaherPg1kwNgfn0x0ylcEcKxhzKdLx3VFXdlVTaLMJ0iYGjkcMFCXpvC3G9L8y2wKpVFVPae/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731351361; c=relaxed/simple;
	bh=36gqcu3cIXGdvsFPHvyxc5v+3gWOt//+iBMclTk4nLU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LgdNGFC6YqGArhyH5B/Jtp35mLYZo1MjR1zTWA5y24EUBUHcAGmWHgoiWM+EedCgza47sqc2uBV0muYt+ojdTjaA20jcKoxX1aETek9yqS6fXjwHMGLqyXa8NkgtMwHFskrKQ3u0rfeRe3fMCPrCZh8YeWjOVNNoTk/mQSDiyBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4XnJfP4bpCz9sSc;
	Mon, 11 Nov 2024 19:55:57 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PDXyYjaex9M0; Mon, 11 Nov 2024 19:55:57 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4XnJfP3Z27z9sSb;
	Mon, 11 Nov 2024 19:55:57 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 4C4BD8B764;
	Mon, 11 Nov 2024 19:55:57 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id 8sdiMvWuXJHA; Mon, 11 Nov 2024 19:55:57 +0100 (CET)
Received: from [192.168.233.59] (unknown [192.168.233.59])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id E15CD8B763;
	Mon, 11 Nov 2024 19:55:56 +0100 (CET)
Message-ID: <0d485547-b3e5-497e-bdc6-b8b8dcfeb47c@csgroup.eu>
Date: Mon, 11 Nov 2024 19:55:56 +0100
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 3/3] module: pre-test setting ro_after_init data
 read-only
To: Daniel Gomez <da.gomez@samsung.com>, Luis Chamberlain
 <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>,
 Sami Tolvanen <samitolvanen@google.com>, Kees Cook <kees@kernel.org>,
 linux-modules@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
References: <737f952790c96a09ad5e51689918b97ef9b29174.1731148254.git.christophe.leroy@csgroup.eu>
 <CGME20241109105007eucas1p10a64348dbd220dd145735eaca3541d38@eucas1p1.samsung.com>
 <a32f2390caf6e0d157ffea6e04f5e5d8629620c2.1731148254.git.christophe.leroy@csgroup.eu>
 <D5HYAAW77P1A.6KLS8F6CVKGS@samsung.com>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <D5HYAAW77P1A.6KLS8F6CVKGS@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 09/11/2024 à 22:03, Daniel Gomez a écrit :
> On Sat Nov 9, 2024 at 11:35 AM CET, Christophe Leroy wrote:
>> To be on the safe side, try to set ro_after_init data section readonly
>> at the same time as rodata. If it fails it will likely fail again
>> later so let's cancel module loading while we still can do it.
>> If it doesn't fail, put it back to read-only, continue module loading
> 
> I think you mean put it back to rw?

Indeed

> 
>> and cross fingers so that it still works after module init. Then it
>> should in principle never fail so add a WARN_ON_ONCE() to get a big
>> fat warning in case it happens anyway.
> 
> I agree this is the best we can do. But I don't think there's any
> guarantee that we won't fail on the second try?

I think if it works once it will always work, see my response to patch 
2/3. But I added that WARN_ON_ONCE() so that if it doesn't at least we 
know it.


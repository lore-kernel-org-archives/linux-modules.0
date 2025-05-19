Received: from 12.mo581.mail-out.ovh.net (12.mo581.mail-out.ovh.net [178.33.107.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DD931B4F09
	for <linux-modules@vger.kernel.org>; Mon, 19 May 2025 10:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.33.107.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747650711; cv=none; b=qOHi00w3ATCQ64b1PUGJU3O405M84jTAUlaTD8W2pe1MgshkY2NK0opXwFQcPvK2noNErFXsd2Mra9iQcHIw75OKLaQV542FHKaTlosAxN5kqZpwizMwuGIonYhflMTK3HLfE8jbrrerUfTtp+neYQrVQGqQpMUfU1w+tGFPOME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747650711; c=relaxed/simple;
	bh=QQeToCJ0LWGGSMRYEMuDE2t1/78PY4tmI2CaW9AwPDw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=KHQbmtndV9oh8DWLCLjKkFh8tK717X8xdxk29loqmTonV/0ac+nPWYgQayAJ66S25okUJJoqBwcb8Txn++TNEMdqfHXafa9NCVMBtpO6eo7GbYtcvyEn3pFbI/bHtwRyaAbK+k0iV7ATQbgFOBMMh2h1/Amq8N0pcS91lLs1Fvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=3mdeb.com; spf=pass smtp.mailfrom=3mdeb.com; dkim=pass (2048-bit key) header.d=3mdeb.com header.i=@3mdeb.com header.b=BnyGX5ba; arc=none smtp.client-ip=178.33.107.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=3mdeb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=3mdeb.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=3mdeb.com header.i=@3mdeb.com header.b="BnyGX5ba"
Received: from director10.ghost.mail-out.ovh.net (unknown [10.108.2.205])
	by mo581.mail-out.ovh.net (Postfix) with ESMTP id 4b18Pn54j8z1DVS
	for <linux-modules@vger.kernel.org>; Mon, 19 May 2025 07:26:37 +0000 (UTC)
Received: from ghost-submission-5b5ff79f4f-kc5tb (unknown [10.108.54.8])
	by director10.ghost.mail-out.ovh.net (Postfix) with ESMTPS id F30861FEA2;
	Mon, 19 May 2025 07:26:36 +0000 (UTC)
Received: from 3mdeb.com ([37.59.142.108])
	by ghost-submission-5b5ff79f4f-kc5tb with ESMTPSA
	id R2cvIizdKmi6LAAAK/IzfQ
	(envelope-from <daniil.klimuk@3mdeb.com>); Mon, 19 May 2025 07:26:36 +0000
Authentication-Results:garm.ovh; auth=pass (GARM-108S002287fa2b5-87d6-43fc-beb3-1edd3c38f61c,
                    4C7B12AA0DC46FE1113010BA642E4FE0F84C70ED) smtp.auth=daniil.klimuk@3mdeb.com
X-OVh-ClientIp:213.192.77.249
Message-ID: <e71bd62c-5ba7-4363-9af1-d9c9de394a54@3mdeb.com>
Date: Mon, 19 May 2025 09:26:36 +0200
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Question: a module for wiping userspace RAM before
 shutdown/reboot/halt
To: Christophe Leroy <christophe.leroy@csgroup.eu>,
 linux-modules@vger.kernel.org, "linux-mm@kvack.org" <linux-mm@kvack.org>
References: <bfe72929-ba4c-4732-9f80-25cc7b95a0c8@3mdeb.com>
 <e55bd90e-8bbf-4eb2-95e2-cc636725a0ae@csgroup.eu>
Content-Language: en-US
From: Danill Klimuk <daniil.klimuk@3mdeb.com>
Autocrypt: addr=daniil.klimuk@3mdeb.com; keydata=
 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
 TIx3Est5
Organization: 3mdeb
In-Reply-To: <e55bd90e-8bbf-4eb2-95e2-cc636725a0ae@csgroup.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 15937394660442281023
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdefvddtjeekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkfffgggfuffvfhfhohgjtgfgsehtkeertddtvdejnecuhfhrohhmpeffrghnihhllhcumfhlihhmuhhkuceouggrnhhiihhlrdhklhhimhhukhesfehmuggvsgdrtghomheqnecuggftrfgrthhtvghrnhepjeekuddtgffguddvgedvtddtheejudeutdejhedutedtffehhfdvudduhfejiedvnecukfhppeduvdejrddtrddtrddupddvudefrdduledvrdejjedrvdegledpfeejrdehledrudegvddruddtkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduvdejrddtrddtrddupdhmrghilhhfrhhomhepuggrnhhiihhlrdhklhhimhhukhesfehmuggvsgdrtghomhdpnhgspghrtghpthhtohepuddprhgtphhtthhopehlihhnuhigqdhmohguuhhlvghssehvghgvrhdrkhgvrhhnvghlrdhorhhgpdfovfetjfhoshhtpehmohehkedumgdpmhhouggvpehsmhhtphhouhht
DKIM-Signature: a=rsa-sha256; bh=bvYtbVByzgmYDRCRfTHFB5oac/4KP5y6HZVKJob90RQ=;
 c=relaxed/relaxed; d=3mdeb.com; h=From; s=ovhmo3617313-selector1;
 t=1747639597; v=1;
 b=BnyGX5baviW3dMmAm7NxUGD7ylYoTj8Tlz061GtdfgSLAmttrIdYNoOwb8zbGmLR+rjPt2N5
 D6XOOk5a6pTioy/rUyXP6/lVHNDEfIUXpl9BT3eRTDtYWkHUTNSd8IyUBvm4twkQ2Gn4+y3tUFv
 Tgno7kJmQUSViEStQAlXqIv427JvrI1yXnb6de0ps+XQ7npZh3zjuX+yy/LUcIDEgN0CGZKjfD1
 ROI+pRC9KABxymD8MeYe5DDmmNYxcCHogcH0K1JEUx9yviAX/OYsFde5i4Nrr84y0drK7aED3tl
 cRp5U5G0jj3LoPBJmOJpbd7+Yd0L9MLG0VkVnJ+lMRvQw==

Hi Christophe, thank you for the answer.

 > What do you mean by 'wiping', do you mean 'clearing' ?

Yes, by 'wiping' I mean 'clearing'.

 > Can you explain the reason this is needed?

Some of our clients want to clear user space RAM during 
shutdown/reboot/halt sequences of Linux kernel, so the process data or 
any other leftovers do not leak outside current Linux kernel session 
(that is to firmware, or the next boot software, etc.). The reason for 
it to be a module that will execute in a specific moment of the 
sequences is to make it more predictable.

I thought that if the clients want to use it, maybe it will be useful 
for others too :).

On 5/17/25 7:25 PM, Christophe Leroy wrote:
>
>
> Le 15/05/2025 à 15:30, Danill Klimuk a écrit :
>
>> Hello everyone. I have received a request to write a Linux kernel module
>> that will wipe any processes leftovers from userspace RAM during/before
>> Linux kernel shutdown/reboot/halt sequences. The reason I am going to do
>> it inside a module is to do it in a more deterministic way that does not
>> depend on any processes. AFAIK Linux kernel does not have any other
>> functionalities to wipe leftovers from RAM apart from the command line
>> arguments "init_on_free" and "init_on_alloc" that results in memory
>> poisoning only during memory allocation and memory deallocation. These
>> arguments cause the kernel to clean processes memory several times
>> during runtime, that is not deterministic because of processes
>> non-deterministic behavior. Hence, I want to bring the memory wiping
>> mechanism in one place and make it more deterministic. The question is:
>>
>> Maybe the Linux kernel already have such functionalities implemented?
>
> Linux memory management topics should be sent to linux-mm@kvack.org
>
>>
>> Currently I am planning to implement the wiping process to be triggered
>> by "reboot_notifier_callback", so to wipe RAM after PID 1 process
>> finishes and no other processes are executing. I am looking forward to
>> merging the module into Linux kernel upstream too.
>
> What do you mean by 'wiping', do you mean 'clearing' ?
>
> Can you explain the reason this is needed ?
>
> Christophe
>
>
-- 
Best regards, Daniil.
3mdeb Zarhus team leader.


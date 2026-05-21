Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1860328B4B
	for <linux-modules@vger.kernel.org>; Thu, 21 May 2026 07:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779350304; cv=none; b=iJVf+Y/jD5EykVMI1hDA/cexkM/oElOlrxzVht+zyheRu7vuxJG+0qmZDaqhJ6jXkdRfzdYqsJhnJmqNiNv1JTfCsmrEJaTXplxP9ZM4PCwEs7EtkpIwZ4kb4ael/dRssKfMQAsK8M37d/MfmEqPFq5qhi8PERn0Cx7q8rM5MJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779350304; c=relaxed/simple;
	bh=fdIHTlNJ5S9w5BaBBxNHieY+5HrJDP909szi2mPAjps=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f1g2VY/UdpJErYPJ0/flHdA8plChV1odahpMy5QingKADAOV7Vqe+nhPOlqIjPZDXLBYT98vQDW5wotHPE1tASbm3yqs9g6F7+OPy7ec5xZC/w5X6v1XN7DMFkvV+lnP6+m03l3vjnko+OJerbWIm257+enwI/qHhg5ONuGzmbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Iv/kUm6n; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Iv/kUm6n"
Message-ID: <81013175-0164-4ad4-a4a7-0cab332b695b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779350290;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qvW89Y5yfvW9tGdg4/aM0qB0CsEzidAsVDHwaWcD2rs=;
	b=Iv/kUm6ntc1nclOZY3Cbub6Jza3tf2c1fxkkBVni4Osz/a52CsxDJaJwW3ZWCAXFi0XiRh
	0uRE7AOVta6oDrhghHpMBu0X351qPMkPHyEeAmHnU5+L1mG27GB0tm/2457Gm6qhe8lkBC
	lA+diiK0q90tc/UJ9UIRzA1ECGTa0g8=
Date: Thu, 21 May 2026 15:57:31 +0800
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 2/8] rust: driver: make `DriverModule` struct pub(crate)
 in `module_driver!`
To: Gary Guo <gary@garyguo.net>, Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun@kernel.org>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>,
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>,
 Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>,
 Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>,
 Aaron Tomlin <atomlin@atomlin.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Daniel Almeida <daniel.almeida@collabora.com>, Arnd Bergmann <arnd@arndb.de>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-modules@vger.kernel.org, driver-core@lists.linux.dev,
 dri-devel@lists.freedesktop.org, nova-gpu@lists.linux.dev
References: <20260519-fix-fops-owner-v1-0-2ded9830da14@linux.dev>
 <20260519-fix-fops-owner-v1-2-2ded9830da14@linux.dev>
 <DIMMSJ6GO6XE.2D3RYBTZ45EW1@garyguo.net>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Alvin Sun <alvin.sun@linux.dev>
In-Reply-To: <DIMMSJ6GO6XE.2D3RYBTZ45EW1@garyguo.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 5/19/26 19:53, Gary Guo wrote:
> On Tue May 19, 2026 at 7:26 AM BST, Alvin Sun wrote:
>> Expose the generated `DriverModule` struct as `pub(crate)` so that
>> driver implementations can reference it via `super::DriverModule`
>> for the `ThisModule` associated type.
> Why is this needed? Child modules can see items super modules.

I misread it — I've already used LocalModule directly in v2.

Best regards,
Alvin

>
> Best,
> Gary
>
>> Signed-off-by: Alvin Sun <alvin.sun@linux.dev>
>> ---
>>   rust/kernel/driver.rs | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/rust/kernel/driver.rs b/rust/kernel/driver.rs
>> index 36de8098754d0..9c7c69c4d2af0 100644
>> --- a/rust/kernel/driver.rs
>> +++ b/rust/kernel/driver.rs
>> @@ -253,7 +253,7 @@ macro_rules! module_driver {
>>           type Ops<$gen_type> = $driver_ops;
>>   
>>           #[$crate::prelude::pin_data]
>> -        struct DriverModule {
>> +        pub(crate) struct DriverModule {
>>               #[pin]
>>               _driver: $crate::driver::Registration<Ops<$type>>,
>>           }

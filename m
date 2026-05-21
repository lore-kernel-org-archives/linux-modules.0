Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 615983A05D7
	for <linux-modules@vger.kernel.org>; Thu, 21 May 2026 08:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779350431; cv=none; b=NNxN5V+0cM5RcJeaVRr35jXEg04wJjYIx/wzHGrbD1h778RNN+RSuX22/yOXi6FdrSbHVWWiw2gnse+CyU7A/3IkHxAtgjYtMHX8y50PkqQvj4HJdwKgm6EJYUFDjv/HJbRoAm17xXqrZccCv2SxMSyq9M3/wBaFEJLVByeZ+hY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779350431; c=relaxed/simple;
	bh=oLp+xtLVVN8N/kbgdazi4V54S6/fp49CZ2bkua9rWvA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RSQyruAmxSZ8ErEkwIbLBgxJeyIGNutS1SypI+dlpg6P3a1ckaIVeB0igurtwW6Pck7JMYQanB+oC87BJ9XyRscPXAiE82yO9iraPG7PPTe1ga7lgGxmu6ue2vQ5bBsxQoSlqIyD/kz9ExsgMgi7ohYYiCFDCARuJt+sWqpUmZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=eZKDvFim; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="eZKDvFim"
Message-ID: <f4e9063b-1def-4380-ad2a-01a0b12c1027@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779350417;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lnVqaFOkUKkSYbg64c5pRbVkOYoIDmxDfZVY5JS/cPw=;
	b=eZKDvFim8VqhBk/sVLqLNGbfeYV91CjMZI07U3viOpNuKFy7EGI4Z78yqXeg6CQ2nYU8fT
	Lcq1/k5qgbrv16RxaBmLpvxgYWGqvEVVZKY0ijjzaR0dWCA8qMGqNUrjjTQP5oqiwfHd3b
	74E7lE0Cd9lpzwYXvgATwU56ia6zZsk=
Date: Thu, 21 May 2026 15:59:58 +0800
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 3/8] rust: drm: add `ThisModule` associated type to
 `Driver` trait
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
 <20260519-fix-fops-owner-v1-3-2ded9830da14@linux.dev>
 <DIMMWHUOLPSH.13JFRHDKDQJGO@garyguo.net>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Alvin Sun <alvin.sun@linux.dev>
In-Reply-To: <DIMMWHUOLPSH.13JFRHDKDQJGO@garyguo.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 5/19/26 19:58, Gary Guo wrote:
> On Tue May 19, 2026 at 7:26 AM BST, Alvin Sun wrote:
>> Add a `ThisModule` associated type bound by `ModuleMetadata` to the
>> `drm::Driver` trait, allowing DRM drivers to expose their module
>> pointer for use in file operations.
> FWIW, I was considering adding this automatically to the `#[vtable]` macro
> (associated types/consts won't have any costs if they're unused anyway).

That's a great suggestion. I've implemented it in v2 — please review.

Best regards,
Alvin

>
> But requiring an explicit specification isn't too bad either.
>
> Best,
> Gary
>
>> Signed-off-by: Alvin Sun <alvin.sun@linux.dev>
>> ---
>>   rust/kernel/drm/driver.rs | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/rust/kernel/drm/driver.rs b/rust/kernel/drm/driver.rs
>> index 5233bdebc9fcd..c798961650c1a 100644
>> --- a/rust/kernel/drm/driver.rs
>> +++ b/rust/kernel/drm/driver.rs
>> @@ -115,6 +115,9 @@ pub trait Driver {
>>   
>>       /// IOCTL list. See `kernel::drm::ioctl::declare_drm_ioctls!{}`.
>>       const IOCTLS: &'static [drm::ioctl::DrmIoctlDescriptor];
>> +
>> +    /// The module implementing this driver.
>> +    type ThisModule: crate::ModuleMetadata;
>>   }
>>   
>>   /// The registration type of a `drm::Device`.

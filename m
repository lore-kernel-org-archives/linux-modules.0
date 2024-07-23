Received: from out-175.mta0.migadu.com (out-175.mta0.migadu.com [91.218.175.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35C4C14C5B5
	for <linux-modules@vger.kernel.org>; Tue, 23 Jul 2024 08:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721724268; cv=none; b=o3IJ7TY5gNshtnujTl+u2yJQc+ZNq+etTClWLcgQ60hORCf/zFX7VxOp5al2rPZ80LH3+u6paaEszQ0FJ9Ato4yNw3bIp7ibhVwPoWXpCZtMHeBWU2ejldkct0UfiqIaIZ7+6memj8ERujU0b0Wa2B1f6QXvI+UAeGnfWHPgPPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721724268; c=relaxed/simple;
	bh=2ZjbRPeeXbrIm0xAnumdD1ly1zV8UN2KljaltnZiPCE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hiLL+H9DYiGWVQMKbhE94/MlAa9wpfRz7hA6XlH26v10JX4dmpp5hCTjv6VR1JibbRzOjYOG3U+rgjoQx+VOX42DK+vp1ZOjZCqsMqqNDyl5ARqyIiXYHWDD1sQjoC2qSfYXcPbkbqYjBo3zGqk/uuKVfv+EeGLq0sKtNmWNwmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=LlpWyiuY; arc=none smtp.client-ip=91.218.175.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LlpWyiuY"
X-Envelope-To: hch@infradead.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1721724265;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NK2EcdiJh2UsKYq9ETH81uD0C/sipi+a4DjtdiFTXK4=;
	b=LlpWyiuY+PZBgxwLd/IpEVDwLE222BpKHgr1RpB7VbGs6XxatJY6uaj7S1+p1f3sA/rhGF
	LBIt7voECdMcUrmmkXTUog+VjPBiXMj9DKY1ALk9NO54Y7OmFs1PVT72nKDJToeJaRnU9n
	woVBW/ixI37h287XNnk+URuOhlDOLe8=
X-Envelope-To: viro@zeniv.linux.org.uk
X-Envelope-To: brauner@kernel.org
X-Envelope-To: jack@suse.cz
X-Envelope-To: clm@fb.com
X-Envelope-To: josef@toxicpanda.com
X-Envelope-To: dsterba@suse.com
X-Envelope-To: tytso@mit.edu
X-Envelope-To: adilger.kernel@dilger.ca
X-Envelope-To: jaegeuk@kernel.org
X-Envelope-To: chao@kernel.org
X-Envelope-To: linux-fsdevel@vger.kernel.org
X-Envelope-To: linux-btrfs@vger.kernel.org
X-Envelope-To: linux-ext4@vger.kernel.org
X-Envelope-To: linux-f2fs-devel@lists.sourceforge.net
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: mcgrof@kernel.org
X-Envelope-To: linux-modules@vger.kernel.org
Message-ID: <b58e6f36-9a13-488a-85d2-913dd758f89b@linux.dev>
Date: Tue, 23 Jul 2024 16:44:14 +0800
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 0/3] Add {init, exit}_sequence_fs() helper function
To: Christoph Hellwig <hch@infradead.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
 David Sterba <dsterba@suse.com>, tytso@mit.edu,
 Andreas Dilger <adilger.kernel@dilger.ca>, Jaegeuk Kim <jaegeuk@kernel.org>,
 Chao Yu <chao@kernel.org>, linux-fsdevel@vger.kernel.org,
 linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
 Luis Chamberlain <mcgrof@kernel.org>, linux-modules@vger.kernel.org
References: <20240711074859.366088-1-youling.tang@linux.dev>
 <Zo-XMrK6luarjfqZ@infradead.org>
Content-Language: en-US, en-AU
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Youling Tang <youling.tang@linux.dev>
In-Reply-To: <Zo-XMrK6luarjfqZ@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Hi, Christoph

On 11/07/2024 16:26, Christoph Hellwig wrote:
> Can we please stop this boilerplate code an instead our __init/__exit
> sections to supper multiple entires per module.  This should be mostly
> trivial, except that we'd probably want a single macro that has the
> init and exit calls so that the order in the section is the same and
> the unroll on failure can walk back form the given offset. e.g.
> something like:
>
> module_subinit(foo_bar_init, foo_bar_exit);
> module_subinit(foo_bar2_init, foo_bar2_exit);
>
>
Thanks for your suggestion,  I re-implemented it using section mode,
and the new patch set [1] has been sent.

[1]: 
https://lore.kernel.org/all/20240723083239.41533-1-youling.tang@linux.dev/T/#md81aaefe0c1fef70a0592d1580cbbb10ec9989b0

Thanks,
Youling.

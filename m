Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DECF371
	for <linux-modules@vger.kernel.org>; Wed,  4 Oct 2023 01:02:34 +0000 (UTC)
Received: from hua.moonlit-rail.com (hua.moonlit-rail.com [45.79.167.250])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F702A9
	for <linux-modules@vger.kernel.org>; Tue,  3 Oct 2023 18:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=moonlit-rail.com; s=rsa2021a; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:To:Subject:MIME-Version:Date:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=hSzvupHiAwU0VeW78tyHz1WL+Jm1mQOYvQU7HKBrlVY=; t=1696381352; x=1698973352; 
	b=S3u3NYXTArgEbEcBMkZa10KBEX7KpMqaom+12GuRg04EnwrBv2KAUGKJqIO9+KFhYUnPz9xML8Y
	uuzUNoHyy6DW2/Z/tmX0YHWNbP71aJoadSwIwEusNsT8WQ6pG4KQ/j4Nb2N+BQMEdnXafAZgHzqf6
	LW8Got17/46DLpq5JPCgke9+MWDebPvO70tvSKe/6yvPvHV6gekHiTGAcDkzU5PrpKWup71lkVKZU
	/v038h252/aPkgV/WQlxnyornXl0Hn2zHzViGLcLv4OI+ZSMWwef71B0Ul0EPS5hSykiHYww4PQCk
	GHqUBcT/fbf2/2n7/g+BZ+s6hA+F6zayFHfA==;
DKIM-Signature: v=1; a=ed25519-sha256; q=dns/txt; c=relaxed/relaxed;
	d=moonlit-rail.com; s=edd2021a; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:To:Subject:MIME-Version:Date:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=hSzvupHiAwU0VeW78tyHz1WL+Jm1mQOYvQU7HKBrlVY=; t=1696381352; x=1698973352; 
	b=DGvT1bcUF5qsBT8Qd3pVidYkqkhoW56F7G9e2s+wooXRchvmKJ7b7IsFedYmSBbN0gx0WPS3WGD
	t0kf6pEEqCg==;
Message-ID: <df84e672-81f2-4f48-a5cf-65eb05ecc242@moonlit-rail.com>
Date: Tue, 3 Oct 2023 21:02:32 -0400
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Unbootable system with kmod-31
To: Lucas De Marchi <lucas.demarchi@intel.com>, linux-modules@vger.kernel.org
References: <acf37f00-cea3-4f77-9c05-3c0301221d2a@moonlit-rail.com>
 <ZRyCzQ67pAlbNOYa@bongo.bofh.it>
 <mmsrsxnmplo7zvh2rmp3zvymaprxj73mrskdjwngfnawkoh5ur@xx5dclgmv6bg>
Content-Language: en-US, en-GB
From: "Kris Karas (Bug Reporting)" <bugs-a21@moonlit-rail.com>
In-Reply-To: <mmsrsxnmplo7zvh2rmp3zvymaprxj73mrskdjwngfnawkoh5ur@xx5dclgmv6bg>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Lucas De Marchi wrote:
> On Tue, Oct 03, 2023 at 11:08:29PM +0200, Marco d'Itri wrote:
>> https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1050586
>
> duplicate of https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1050582 ?

Ah, that does seem the better bug report, as it triages it down to the 
dictionary size.

> Maybe that patch needs to propagate back to 6.5?

If you mean that modules_install doesn't pass the right parameters to 
/bin/xz, then definitely.  I've reported on bugzilla variously over the 
years about things "fixed in Linus's tree" that never got queued into 
Greg KH's tree.

Perhaps kmod should be updated to only call finit_module() when the 
kernel_version is >= known good, or when not using xz compression, and 
use init_module() elsewhere?

In any case, I didn't see the Debian bug report earlier.  Using 
Slackware here with custom-config mainline kernels.

Kris

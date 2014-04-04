Return-Path: <mmarek@suse.cz>
Message-ID: <533E8272.8070102@suse.cz>
Date: Fri, 04 Apr 2014 11:59:14 +0200
From: Michal Marek <mmarek@suse.cz>
MIME-Version: 1.0
To: Lucas De Marchi <lucas.de.marchi@gmail.com>
CC: linux-modules <linux-modules@vger.kernel.org>
Subject: Re: [PATCH 1/3] testsuite: Do not run tests with *.ko.gz if zlib
 is not enabled
References: <1396603936-13045-1-git-send-email-mmarek@suse.cz> <CAKi4VAKqM9sC26=qkWJ6Mw=u9YrbyBa4JGSN=pK5T8NZzQUSdA@mail.gmail.com>
In-Reply-To: <CAKi4VAKqM9sC26=qkWJ6Mw=u9YrbyBa4JGSN=pK5T8NZzQUSdA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-modules.vger.kernel.org>

On 2014-04-04 11:47, Lucas De Marchi wrote:
> On Fri, Apr 4, 2014 at 6:32 AM, Michal Marek <mmarek@suse.cz> wrote:
>> Unfortunately, all the depmod tests depend on zlib.
> 
> wouldn't it be better to decompress these files so we remove the dependencies?

I'm not against it. I thought the files were compressed so the the zlib
support is tested. I can post a patch that decompresses them.

Michal

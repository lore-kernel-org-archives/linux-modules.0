Return-Path: <kay@vrfy.org>
MIME-Version: 1.0
In-Reply-To: <CAKi4VAJ78KbPGtsjopGDKPbxNogSG1=pNJcg7N2HuLzpz54=7Q@mail.gmail.com>
References: <1442004956-3868-1-git-send-email-labbott@fedoraproject.org> <CAKi4VAJ78KbPGtsjopGDKPbxNogSG1=pNJcg7N2HuLzpz54=7Q@mail.gmail.com>
From: Kay Sievers <kay@vrfy.org>
Date: Thu, 17 Sep 2015 00:35:24 +0100
Message-ID: <CAPXgP12KGbU_yvYhfeFYiy=7=yFT=5AAF-QNkL2NzEoKWiAVVQ@mail.gmail.com>
Subject: Re: [PATCH 0/4] depmod and modprobe error message fixups
To: Lucas De Marchi <lucas.de.marchi@gmail.com>
Cc: Laura Abbott <labbott@fedoraproject.org>, Lucas De Marchi <lucas.demarchi@intel.com>,
	linux-modules <linux-modules@vger.kernel.org>, Lennart Poettering <lennart@poettering.net>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-modules.vger.kernel.org>

On Sat, Sep 12, 2015 at 8:05 PM, Lucas De Marchi
<lucas.de.marchi@gmail.com> wrote:
> Hi Laura,
>
> CC'ing Lennart and Kay
>
> On Fri, Sep 11, 2015 at 5:55 PM, Laura Abbott <labbott@fedoraproject.org> wrote:
>>
>> While doing some experimental work with kernel packaging,
>> I found a few places where a lack of error messages made
>> it difficult to figure out what was going on. This cleans
>> up the error messages to be a bit more useful.
>>
>> Laura Abbott (4):
>>   build: Properly check for Cython
>>   modprobe: Add appropriate error message when path is missing
>>   depmod: Fix message printing before log_setup_kmod_log
>>   depmod: Add error message for bad version
>
> Thanks very much for the patches. I commented on each of them
> individually.  Could you send a v2 with the comments addressed?
>
> For the cython patch, I'm not sure. I don't want the cython dependency
> to be a one off since there are other things we ship prebuilt in
> packages like the man pages. Maybe just stop shipping prebuilt stuff
> in the distributed file like systemd did would be ok. Lennart, Kay,
> did you had any problems with distributions due to this?

No known problems I know of. We will not got back to pre-created content..

Kay

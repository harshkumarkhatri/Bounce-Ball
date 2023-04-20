import 'package:bounce_ball/state/ball_size_provider.dart';
import 'package:bounce_ball/state/ball_speed_provider.dart';
import 'package:bounce_ball/state/reset_provider.dart';
import 'package:bounce_ball/state/screen_shake_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shake/shake.dart';

class BouncingBallScreen extends ConsumerStatefulWidget {
  const BouncingBallScreen({super.key});

  @override
  ConsumerState<BouncingBallScreen> createState() => _BouncingBallScreenState();
}

class _BouncingBallScreenState extends ConsumerState<BouncingBallScreen>
    with TickerProviderStateMixin {
  late AnimationController controller;
  late Animation anim;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _initialLoadingState();
  }

  void _initialLoadingState() {
    final localBallSpeedProvider = ref.watch(ballSpeedProvider);
    final localScreenShakeProvider = ref.watch(screenShakeProvider);
    final localResetProvider = ref.watch(resetProvider);
    final localBallSizeProvider = ref.watch(ballSizeProvider);

    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: localBallSpeedProvider.value),
      lowerBound: 0.0,
      value: 250.0,
      upperBound: 500.0,
    );

    anim = ColorTween(
      begin: Colors.green,
      end: Colors.yellow,
    ).animate(
      controller,
    );

    ShakeDetector _ = ShakeDetector.autoStart(
      onPhoneShake: () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Shake detected! Stopping ball'),
          ),
        );
        localScreenShakeProvider.updateScreenShake(true);
      },
      minimumShakeCount: 1,
      shakeSlopTimeMS: 500,
      shakeCountResetTime: 3000,
      shakeThresholdGravity: 2.7,
    );

    controller.addListener(() {
      if (localBallSizeProvider.resizeBall) {
        if (localBallSizeProvider.value >= 50 &&
            localBallSizeProvider.isValueInc) {
          if (localBallSizeProvider.value == 100) {
            localBallSizeProvider.updateValueInc(false);
            return;
          }
          localBallSizeProvider.incBallSize();
        } else if (localBallSizeProvider.value == 100 ||
            !localBallSizeProvider.isValueInc) {
          if (localBallSizeProvider.value == 50) {
            localBallSizeProvider.updateValueInc(true);
            if (!localBallSizeProvider.resizeBall) {
              localBallSizeProvider.updateBallResize(false);
            }
            return;
          }
          localBallSizeProvider.decBallSize();
        }
      }
      if (localScreenShakeProvider.isScreenShaked) {
        localBallSizeProvider.updateBallResize(false);
        if (localBallSizeProvider.value > 50) {
          localBallSizeProvider.decBallSize();
        }
        if (localBallSizeProvider.value == 50) {
          if (!localResetProvider.isReset) {
            controller.stop();
          }
          localResetProvider.updateReset(false);
          localScreenShakeProvider.updateScreenShake(false);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 16.0),
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              AnimatedBuilder(
                animation: anim,
                builder: (context, child) {
                  return _buildAnimationBuilderChild(child);
                },
                child: _buildBall(),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 16.0,
                  right: 16.0,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    _buildSlider(),
                    _buildResetButton(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAnimationBuilderChild(Widget? child) {
    final localBallSizeProvider = ref.watch(ballSizeProvider);

    return Padding(
      padding: const EdgeInsets.only(bottom: 170.0),
      child: InkWell(
        onTap: () {
          if (!localBallSizeProvider.resizeBall) {
            localBallSizeProvider.updateBallResize(true);
          }
          if (!controller.isAnimating) {
            controller.repeat(reverse: true);
          }
        },
        child: Center(
          child: Container(
            height: 500.0,
            margin: EdgeInsets.only(top: controller.value),
            child: child ?? const SizedBox.shrink(),
          ),
        ),
      ),
    );
  }

  Widget _buildBall() {
    final localBallSizeProvider = ref.watch(ballSizeProvider);

    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: anim.value,
      ),
      width: localBallSizeProvider.value,
      height: localBallSizeProvider.value,
    );
  }

  Widget _buildSlider() {
    final localBallSpeedProvider = ref.watch(ballSpeedProvider);

    return Expanded(
      flex: 7,
      child: SizedBox(
        height: 40.0,
        child: Slider(
          min: 1.0,
          value: localBallSpeedProvider.value.toDouble(),
          max: 6.0,
          divisions: 5,
          label: localBallSpeedProvider.value.round().toString(),
          onChanged: (double value) {
            localBallSpeedProvider.updateBallSpeed(value.toInt());
            controller.duration =
                Duration(seconds: localBallSpeedProvider.value);
            controller.stop();
            controller.repeat(reverse: true);
          },
        ),
      ),
    );
  }

  Widget _buildResetButton() {
    final localResetProvider = ref.watch(resetProvider);
    final localBallSpeedProvider = ref.watch(ballSpeedProvider);
    final localScreenShakeProvider = ref.watch(screenShakeProvider);

    return Expanded(
      flex: 3,
      child: InkWell(
        onTap: () {
          localBallSpeedProvider.updateBallSpeed(1);
          controller.duration = Duration(seconds: localBallSpeedProvider.value);
          controller.stop();
          controller.repeat(reverse: true);
          localScreenShakeProvider.updateScreenShake(true);
          localResetProvider.updateReset(true);
        },
        child: Container(
          height: 40.0,
          width: 40.0,
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(
              12.0,
            ),
          ),
          alignment: Alignment.center,
          child: Text(
            "Reset",
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Colors.white,
                  fontSize: 16.0,
                  fontWeight: FontWeight.w600,
                ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}

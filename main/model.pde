interface CombatOption {
  public double getMagnitude();
  public Effect getEffect();
  public boolean hasEffect();
  public OptionType getType();
}

interface Stat {
  public double getCurrentValue();
  public double getMaxValue();
  public double getMinValue();
  public void addToCurrentValue(double value);
  public void substractToCurrentValue(double value);
}

interface Playable {
  public PShape getModel();
  public CreatureStats getStats();
  public boolean isAlive();
}

class Creature implements Playable {

  PShape model;
  CreatureStats stats;

  public Creature(PShape model, CreatureStats stats) {
    this.model = model;
    this.stats = stats;
  }

  public PShape getModel() {
    return model;
  }

  public CreatureStats getStats() {
    return stats;
  }

  public boolean isAlive() {
    Map<CombatStat, Stat> map = stats.getStatsMap();
    if (map.containsKey(CombatStat.HEALTH)) {
      Stat health = map.get(CombatStat.HEALTH);
      return health.getCurrentValue() == health.getMinValue();
    }
    return false;
  }
}

class Effect {
}

class Health implements Stat {

  private double currentValue;
  private double maxValue;
  private double minValue;

  public Health(double maxValue) {
    this.maxValue = maxValue;
    minValue = 0;
    currentValue = maxValue;
  }

  public double getCurrentValue() {
    return currentValue;
  }

  public double getMaxValue() {
    return maxValue;
  }

  public double getMinValue() {
    return minValue;
  }

  public void addToCurrentValue(double value) {
    currentValue = Math.min(currentValue + value, maxValue);
  }

  public void substractToCurrentValue(double value) {
    currentValue = Math.max(currentValue - value, minValue);
  }
}

class Attack implements Stat {

  private double currentValue;
  private double maxValue;
  private double minValue;

  public Attack(double maxValue) {
    this.maxValue = maxValue;
    minValue = 0;
    currentValue = maxValue;
  }

  public double getCurrentValue() {
    return currentValue;
  }

  public double getMaxValue() {
    return maxValue;
  }

  public double getMinValue() {
    return minValue;
  }

  public void addToCurrentValue(double value) {
    currentValue = Math.min(currentValue + value, maxValue);
  }

  public void substractToCurrentValue(double value) {
    currentValue = Math.max(currentValue - value, minValue);
  }
}

class Defense implements Stat {

  private double currentValue;
  private double maxValue;
  private double minValue;

  public Defense(double maxValue) {
    this.maxValue = maxValue;
    minValue = 0;
    currentValue = maxValue;
  }

  public double getCurrentValue() {
    return currentValue;
  }

  public double getMaxValue() {
    return maxValue;
  }

  public double getMinValue() {
    return minValue;
  }

  public void addToCurrentValue(double value) {
    currentValue = Math.min(currentValue + value, maxValue);
  }

  public void substractToCurrentValue(double value) {
    currentValue = Math.max(currentValue - value, minValue);
  }
}

class Speed implements Stat {

  private double currentValue;
  private double maxValue;
  private double minValue;

  public Speed(double maxValue) {
    this.maxValue = maxValue;
    minValue = 0;
    currentValue = maxValue;
  }

  public double getCurrentValue() {
    return currentValue;
  }

  public double getMaxValue() {
    return maxValue;
  }

  public double getMinValue() {
    return minValue;
  }

  public void addToCurrentValue(double value) {
    currentValue = Math.min(currentValue + value, maxValue);
  }

  public void substractToCurrentValue(double value) {
    currentValue = Math.max(currentValue - value, minValue);
  }
}

class CreatureStats {

  private Map<CombatStat, Stat> map;

  public CreatureStats(Health health, Attack attack, Defense defense, Speed speed) {
    map = new HashMap<CombatStat, Stat>();
    map.put(CombatStat.HEALTH, health);
    map.put(CombatStat.ATTACK, attack);
    map.put(CombatStat.DEFENSE, defense);
    map.put(CombatStat.SPEED, speed);
  }

  public Map<CombatStat, Stat> getStatsMap() {
    return map;
  }
}

enum OptionType {
  Offensive, Defensive;
}

enum CombatStat {
  HEALTH, ATTACK, DEFENSE, SPEED;
}
